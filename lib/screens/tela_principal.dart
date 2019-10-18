import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:need_an_arm/widgets/connection.dart';
import 'package:provider/provider.dart';

import '../providers/comandos_provider.dart';
import '../widgets/floating_action_button.dart';
import '../widgets/controles.dart';
import '../widgets/servos.dart';
import '../widgets/drawer.dart';

enum ServoAtivo {
  Nenhum,
  Inferior,
  Superior,
}

// REGEX IP \b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b

class TelaPrincipal extends StatefulWidget {
  static const routeName = '/tela-principal';

  @override
  TelaPrincipalState createState() => TelaPrincipalState();
}

class TelaPrincipalState extends State<TelaPrincipal> {
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
          IconButton(
            icon: Icon(Icons.restore),
            onPressed: () {
              print('Reset');
              setState(() {
                _isConnected = false;
                ipProvider.socket.close();
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
                var ipPattern = r"\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b";
                RegExp regExp = new RegExp(ipPattern);

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
                // else if (regExp.hasMatch(enteredIP)) {
                //   print('No match');
                // }

                ipProvider.connect(enteredIP);

                if (ipProvider.connected) {
                  setState(() {
                   _isConnected = true; 
                  });
                } else {
                  return;
                }
                
                print(ipProvider.socket);
              },
            )
          : mainScreenFunc(ipProvider.socket),
      // FAB que irá realizar a função de gravar
      // TO DO: se estiver gravando o FAB irá mudar para parar a gravação
      floatingActionButton: _isConnected ? FabGravar() : null,
    );
  }

  Widget mainScreenFunc(Socket ip) {
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
          _servoSelecionado == ServoAtivo.Superior
              ? ControlesWidget(Icons.arrow_drop_up, 110, () {
                  ip.write('c');
                  ip.write('e');
                  print('Superior Alto C & E');
                })
              : ControlesWidget(
                  Icons.arrow_drop_up, 110, null), // controle cima
          // row para criar os botões esquerda, grab e direita
          _servoSelecionado == ServoAtivo.Inferior
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ControlesWidget(Icons.arrow_left, 110, () {
                      ip.write('b');
                      print('Inferior B');
                    }), // controle esquerda
                    ControlesWidget(Icons.radio_button_unchecked, 100, () {
                      ip.write('g');
                      print('Garra/Grab');
                    }), // controle grab
                    ControlesWidget(Icons.arrow_right, 110, () {
                      ip.write('a');
                      print('Inferior A');
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
                        ip.write('0:0:0:0:Open');
                        print('Garra/Grab');
                      },
                    ), // controle grab
                    ControlesWidget(
                        Icons.arrow_right, 110, null), // controle direita
                  ],
                ), // fim row
          _servoSelecionado == ServoAtivo.Superior
              ?
              // controle down
              ControlesWidget(Icons.arrow_drop_down, 110, () {
                  ip.write('d');
                  ip.write('f');
                  print('Inferior Baixo D & F');
                })
              : ControlesWidget(Icons.arrow_drop_down, 110, null),

          // slider de velocidade
          Text('Selecione a precisão'),
          Slider(
            activeColor: Theme.of(context).accentColor,
            value: _valorSlider.toDouble(),
            min: 0.0,
            max: 10000.0,
            divisions: 100,
            label: '$_valorSlider',
            onChanged: (double newValue) {
              setState(() {
                _valorSlider = newValue.round();
              });
            },
          ),
        ],
      ),
    );
  }

  void _submitIP() {
    var ipPattern = r"\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b";
    RegExp regExp = new RegExp(ipPattern);

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
    } else if (regExp.hasMatch(enteredIP)) {
      print('No match');
    }

    _tryConnect(enteredIP);
  }

  void _tryConnect(String host) async {
    try {
      print('Tentando conectar em $host...');
      s = await Socket.connect(host, 80);
      print('Conectado com sucesso em $host');
      setState(() {
        _isConnected = true;
      });
    } catch (e) {
      print('Falha ao conectar-se em $host\n$e');
    }
  }
}
