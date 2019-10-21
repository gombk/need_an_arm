import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/comandos_provider.dart';
import '../widgets/controles.dart';
import '../widgets/servos.dart';
import '../widgets/lista_comandos.dart';
import '../widgets/drawer.dart';

enum ServoAtivo {
  Nenhum,
  Inferior,
  Medio,
  Superior,
}

class RecordingScreen extends StatefulWidget {
  static const routeName = '/recording-screen';

  @override
  _RecordingScreenState createState() => _RecordingScreenState();
}

class _RecordingScreenState extends State<RecordingScreen> {
  var _servoSelecionado = ServoAtivo.Nenhum;
  int _valorSlider = 0;

  @override
  Widget build(BuildContext context) {
    final cmdProvider = Provider.of<ComandosProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Need an Arm - Gravando'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.restore_page),
            onPressed: () {
              setState(() {
                cmdProvider.resetComando();
              });
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          // coluna principal, armazena todos os widgets
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // botões de controle do servo
            Row(
              // centralizado
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ButtonServoWidget(() {
                    setState(() {
                      _servoSelecionado = ServoAtivo.Inferior;
                    });
                  }, 'Inferior'),
                ),
                //
                //
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ButtonServoWidget(() {
                    setState(() {
                      _servoSelecionado = ServoAtivo.Medio;
                    });
                  }, 'Medio'),
                ),
                //
                //
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ButtonServoWidget(() {
                    setState(() {
                      _servoSelecionado = ServoAtivo.Superior;
                    });
                  }, 'Superior'),
                ),
              ],
            ),
            _servoSelecionado == ServoAtivo.Superior ||
                    _servoSelecionado == ServoAtivo.Medio
                ? ControlesWidget(Icons.arrow_drop_up, 110, () {
                    if (_servoSelecionado == ServoAtivo.Medio) {
                      setState(() {
                        cmdProvider.calcAngServo('S3', 'UP', _valorSlider);
                      });
                      cmdProvider.socket.write(cmdProvider.servoComando);
                    } else {
                      setState(() {
                        cmdProvider.calcAngServo('S2', 'UP', _valorSlider);
                      });
                      cmdProvider.socket.write(cmdProvider.servoComando);
                    }
                  })
                : ControlesWidget(
                    Icons.arrow_drop_up, 110, null), // controle cima
            // row para criar os botões esquerda, grab e direita
            _servoSelecionado == ServoAtivo.Inferior
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ControlesWidget(Icons.arrow_left, 110, () {
                        setState(() {
                          cmdProvider.calcAngServo('S1', 'E', _valorSlider);
                          cmdProvider.socket.write(cmdProvider.servoComando);
                        });
                      }), // controle esquerda
                      ControlesWidget(Icons.radio_button_unchecked, 100, () {
                        setState(() {
                          cmdProvider.garra();
                          cmdProvider.socket.write(cmdProvider.servoComando);
                        });
                      }), // controle grab
                      ControlesWidget(Icons.arrow_right, 110, () {
                        setState(() {
                          cmdProvider.calcAngServo('S1', 'D', _valorSlider);
                          cmdProvider.socket.write(cmdProvider.servoComando);
                        });
                      }) // controle direita
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ControlesWidget(
                          Icons.arrow_left, 110, null), // controle esquerda
                      ControlesWidget(Icons.radio_button_unchecked, 100, () {
                        setState(() {
                          cmdProvider.garra();
                          cmdProvider.socket.write(cmdProvider.servoComando);
                        });
                      }), // controle grab
                      ControlesWidget(
                          Icons.arrow_right, 110, null), // controle direita
                    ],
                  ), // fim row
            _servoSelecionado == ServoAtivo.Superior ||
                    _servoSelecionado == ServoAtivo.Medio
                ?
                // controle down
                ControlesWidget(Icons.arrow_drop_down, 110, () {
                    if (_servoSelecionado == ServoAtivo.Medio) {
                      setState(() {
                       cmdProvider.calcAngServo('S3', 'DOWN', _valorSlider);
                       cmdProvider.socket.write(cmdProvider.servoComando); 
                      });
                    } else {
                      setState(() {
                        cmdProvider.calcAngServo('S2', 'DOWN', _valorSlider);
                        cmdProvider.socket.write(cmdProvider.servoComando);
                      });
                    }
                  })
                : ControlesWidget(Icons.arrow_drop_down, 110, null),

            // slider de velocidade
            Text('Selecione a precisão'),
            Slider(
              activeColor: Theme.of(context).accentColor,
              value: _valorSlider.toDouble(),
              min: 0.0,
              max: 180.0,
              divisions: 180,
              label: '$_valorSlider',
              onChanged: (double newValue) {
                setState(() {
                  _valorSlider = newValue.round();
                });
              },
            ),

            Container(
              height: 150,
              width: 300,
              child: Card(
                child: ListaComandos(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.stop),
        onPressed: () {
          print('Stop recording');
          setState(() {
            cmdProvider.changeMode();
          });
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
