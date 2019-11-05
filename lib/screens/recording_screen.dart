import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../providers/comandos_provider.dart';
import '../widgets/controles.dart';
import '../widgets/servos.dart';
import '../widgets/lista_comandos.dart';
import '../widgets/options_drawer.dart';

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
  int _precisao = 0;
  int _delay = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void didChangeDependencies() {
    getPrecisionValue().then(valorPrecisao);
    getDelayValue().then(valorDelay);
    print('');
    super.didChangeDependencies();
  }

  void updateSharedPrefs() {
    getPrecisionValue().then(valorPrecisao);
    getDelayValue().then(valorDelay);
  }

  void valorPrecisao(int precisao) {
    setState(() {
      _precisao = precisao;
    });
  }

  void valorDelay(int delay) {
    setState(() {
      _delay = delay;
    });
  }

  @override
  Widget build(BuildContext context) {
    final cmdProvider = Provider.of<ComandosProvider>(context);

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Need an Arm - Gravando'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.restore_page),
            onPressed: () {
              updateSharedPrefs();
              setState(() {
                cmdProvider.resetComando();
              });
            },
          ),
        ],
        leading: IconButton(
          icon: Icon(Icons.settings_applications),
          onPressed: () => _scaffoldKey.currentState.openDrawer(),
        ),
      ),
      drawer: OptionsDrawer(),
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
                      updateSharedPrefs();
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
                      updateSharedPrefs();
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
                      updateSharedPrefs();
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
                        updateSharedPrefs();
                        cmdProvider.calcAngServo(
                            servo: 'S3', direcao: 'UP', delay: _delay, precisao: _precisao);
                      });
                      cmdProvider.socket.write(cmdProvider.servoComando);
                    } else {
                      setState(() {
                        updateSharedPrefs();
                        cmdProvider.calcAngServo(
                            servo: 'S2', direcao: 'UP', delay: _delay, precisao: _precisao);
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
                          updateSharedPrefs();
                          cmdProvider.calcAngServo(servo: 'S1', direcao: 'E', delay: _delay, precisao: _precisao);
                        });
                        cmdProvider.socket.write(cmdProvider.servoComando);
                      }), // controle esquerda
                      ControlesWidget(Icons.radio_button_unchecked, 100, () {
                        setState(() {
                          updateSharedPrefs();
                          cmdProvider.garra();
                        });
                        cmdProvider.socket.write(cmdProvider.servoComando);
                      }), // controle grab
                      ControlesWidget(Icons.arrow_right, 110, () {
                        setState(() {
                          updateSharedPrefs();
                          cmdProvider.calcAngServo(servo: 'S1', direcao: 'D', delay: _delay, precisao: _precisao);
                        });
                        cmdProvider.socket.write(cmdProvider.servoComando);
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
                          updateSharedPrefs();
                          cmdProvider.garra();
                        });
                        cmdProvider.socket.write(cmdProvider.servoComando);
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
                        updateSharedPrefs();
                        cmdProvider.calcAngServo(servo: 'S3', direcao: 'DOWN', delay: _delay, precisao: _precisao);
                      });
                      cmdProvider.socket.write(cmdProvider.servoComando);
                    } else {
                      setState(() {
                        updateSharedPrefs();
                        cmdProvider.calcAngServo(servo: 'S2', direcao: 'DOWN', delay: _delay, precisao: _precisao);
                      });
                      cmdProvider.socket.write(cmdProvider.servoComando);
                    }
                  })
                : ControlesWidget(Icons.arrow_drop_down, 110, null),

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

Future<int> getPrecisionValue() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  return prefs.getInt('precision');
}

Future<int> getDelayValue() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  return prefs.getInt('delay');
}
