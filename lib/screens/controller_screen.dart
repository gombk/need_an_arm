import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:need_an_arm/widgets/connection.dart';
import 'package:need_an_arm/widgets/lista_comandos.dart';
import 'package:provider/provider.dart';

import '../providers/comandos_provider.dart';
import '../widgets/floating_action_button.dart';
import '../widgets/controles.dart';
import '../widgets/servos.dart';
import '../widgets/drawer.dart';

enum ServoAtivo {
  Nenhum,
  Inferior,
  Medio,
  Superior,
}

// REGEX IP \b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b

class ControllerScreen extends StatefulWidget {
  static const routeName = '/tela-principal';

  @override
  ControllerScreenState createState() => ControllerScreenState();
}

class ControllerScreenState extends State<ControllerScreen> {
  final _ipController = TextEditingController();
  var _servoSelecionado = ServoAtivo.Nenhum;
  int _valorSlider = 0;

  Socket s;
  bool _isConnected = false;

  @override
  void dispose() {
    s.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ipProvider = Provider.of<ComandosProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: _isConnected == false
            ? Text('Conectar ao Socket')
            : Text('Need an arm - Controlador'),
        actions: <Widget>[
          _isConnected == false
              ? IconButton(
                  icon: Icon(Icons.navigate_next),
                  onPressed: () {
                    setState(() {
                      _isConnected = true;
                    });
                  },
                )
              : IconButton(
                  icon: Icon(Icons.restore),
                  onPressed: () {
                    print('Reset');
                    ipProvider.socket.close();
                    setState(() {
                      _isConnected = false;
                      _servoSelecionado = ServoAtivo.Nenhum;
                    });
                  },
                ),
        ],
      ),
      drawer: AppDrawer(),
      body: _servoSelecionado == ServoAtivo.Nenhum && _isConnected == false
          ? ConnectionWidget(
              ipController: _ipController,
              submitIp: () {
                if (_ipController.text.isEmpty) {
                  Fluttertoast.showToast(
                    msg: 'O IP não pode ser vazio',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    fontSize: 16.0,
                  );
                  return;
                }

                final enteredIP = _ipController.text;

                if (enteredIP.isEmpty) {
                  print('$enteredIP está vazio');
                  return;
                }

                ipProvider.connect(enteredIP);

                // ipProvider.onLoading(context, enteredIP);

                if (ipProvider.connected) {
                  setState(() {
                    _isConnected = true;
                  });
                } else {
                  setState(() {
                    _isConnected = false;
                  });
                }
              },
            )
          : controllerScreenFunc(ipProvider.socket),
      // FAB que irá realizar a função de gravar
      // TO DO: se estiver gravando o FAB irá mudar para parar a gravação
      floatingActionButton: _isConnected ? FabGravar() : null,
    );
  }

  Widget controllerScreenFunc(Socket ip) {
    var cServo = ComandosProvider();
    return SingleChildScrollView(
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
                    cServo.calcAngServo(
                        servo: 'S3', direcao: 'UP', precisao: _valorSlider);
                    // ip.write(cServo.servoComando);
                  } else {
                    cServo.calcAngServo(
                        servo: 'S2', direcao: 'UP', precisao: _valorSlider);
                    // ip.write(cServo.servoComando);
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
                      cServo.calcAngServo(
                          servo: 'S1', direcao: 'E', precisao: _valorSlider);
                      // ip.write(cServo.servoComando);
                    }), // controle esquerda
                    ControlesWidget(Icons.radio_button_unchecked, 100, () {
                      cServo.garra();
                      // ip.write(cServo.servoComando);
                      print('Garra/Grab');
                    }), // controle grab
                    ControlesWidget(Icons.arrow_right, 110, () {
                      cServo.calcAngServo(
                          servo: 'S1', direcao: 'D', precisao: 5);
                      // ip.write(cServo.servoComando);
                    }) // controle direita
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ControlesWidget(
                        Icons.arrow_left, 110, null), // controle esquerda
                    ControlesWidget(
                      Icons.radio_button_unchecked,
                      100,
                      () {
                        cServo.garra();
                        // ip.write(cServo.servoComando);
                      },
                    ), // controle grab
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
                    cServo.calcAngServo(
                        servo: 'S3', direcao: 'DOWN', precisao: _valorSlider);
                  } else {
                    cServo.calcAngServo(
                        servo: 'S3', direcao: 'DOWN', precisao: _valorSlider);
                    // ip.write(cServo.servoComando);
                  }
                })
              : ControlesWidget(Icons.arrow_drop_down, 110, null),

          // slider de velocidade
          Text('Selecione a precisão'),
          Slider(
            activeColor: Colors.blue,
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
          // Container(
          //   height: 150,
          //   width: 300,
          //   child: Card(
          //     child: ListaComandos(),
          //   ),
          // ),
        ],
      ),
    );
  }
}
