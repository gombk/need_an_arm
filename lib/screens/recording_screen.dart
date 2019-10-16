import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './tela_principal.dart';
import '../widgets/controles.dart';
import '../widgets/servos.dart';
import '../widgets/lista_comandos.dart';
import '../widgets/drawer.dart';

enum ServoAtivo {
  Nenhum,
  Inferior,
  Superior,
}

class RecordingScreen extends StatefulWidget {
  static const routeName = '/recording-screen';
  final Socket channel;

  RecordingScreen({@required this.channel});

  @override
  _RecordingScreenState createState() => _RecordingScreenState();
}

class _RecordingScreenState extends State<RecordingScreen> {
  var _servoSelecionado = ServoAtivo.Nenhum;
  int _valorSlider = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Need an Arm - Gravando'),
        // actions: <Widget>[
        //   IconButton(
        //     icon: Icon(Icons.stop),
        //     onPressed: () {
        //       TODO: Alguma coisa aqui
        //       });
        //     },
        //   ),
        // ],
      ),
      drawer: AppDrawer(),
      body: Column(
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
                      print('Inferior B');
                    }), // controle esquerda
                    ControlesWidget(Icons.radio_button_unchecked, 100, () {
                      print('Garra/Grab');
                    }), // controle grab
                    ControlesWidget(Icons.arrow_right, 110, () {
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
                  print('Inferior Baixo D & F');
                })
              : ControlesWidget(Icons.arrow_drop_down, 110, null),

          // slider de velocidade
          Text('Selecione a precisão'),
          Slider(
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

          Container(
            height: 150,
            width: 300,
            child: Card(
              child: ListaComandos(),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.stop),
        onPressed: () {
          print('Stop recording');
          setState(() {
            // do envia os dados
          });
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
