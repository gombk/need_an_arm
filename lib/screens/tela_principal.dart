import 'dart:io';

import 'package:flutter/material.dart';

import '../widgets/controles.dart';
import '../widgets/servos.dart';
import '../widgets/lista_comandos.dart';
import '../widgets/drawer.dart';
import '../models/comandos.dart';
import '../providers/comandos_provider.dart';

enum ServoAtivo {
  Nenhum,
  Inferior,
  Superior,
}

class TelaPrincipal extends StatefulWidget {
  static const routeName = '/tela-principal';
  final Socket channel;

  TelaPrincipal({Key key, this.channel}) : super(key: key);

  @override
  _TelaPrincipalState createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  // define o valor do slider, provavelmente será passado para um arquivo de controle
  int _valorSlider = 0;
  Comandos comandos;
  ComandosProvider cmdProvider;
  var _servoSelecionado = ServoAtivo.Nenhum;
  bool _isLive = false;

  @override
  void dispose() {
    widget.channel.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Need an arm'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.restore),
            onPressed: () {
              print('Reset');
              setState(() {
                _servoSelecionado = ServoAtivo.Nenhum;
              });
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: _servoSelecionado == ServoAtivo.Nenhum
          ? mainScreenNull()
          : mainScreenFunc(),
      // FAB que irá realizar a função de gravar
      // TO DO: se estiver gravando o FAB irá mudar para parar a gravação
      floatingActionButton: _isLive
          ? FloatingActionButton(
              child: Icon(Icons.stop),
              onPressed: () {
                print('Stop recording');
                setState(() {
                  _isLive = false;
                });
              },
            )
          : FloatingActionButton(
              child: Icon(Icons.add_box),
              // o método onPressed irá abrir um diálogo perguntar se quer começar a gravação
              onPressed: () {
                if (_servoSelecionado == ServoAtivo.Nenhum) {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: Text('Nenhum servo selecionado'),
                      content: Text(
                          'Por favor, selecione o servo superior ou inferior acima'),
                      actions: <Widget>[
                        FlatButton(
                          child: Text('Ok'),
                          onPressed: () => Navigator.of(ctx).pop(),
                        ),
                      ],
                    ),
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: Text('Gravar comandos'),
                      content: Text(
                          'Você deseja começar a gravar os seus comandos?'),
                      actions: <Widget>[
                        FlatButton(
                          child: Text('Não'),
                          onPressed: () {
                            print('Não');
                            Navigator.of(ctx).pop();
                          },
                        ),
                        FlatButton(
                          child: Text('Sim'),
                          onPressed: () {
                            print('Sim');
                            setState(() {
                              _isLive = true;
                            });
                            Navigator.of(ctx).pop();
                          },
                        ),
                      ],
                    ),
                  );
                }
              }),
    );
  }

  Widget mainScreenFunc() {
    return Column(
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
                widget.channel.write('c');
                widget.channel.write('e');
                print('Superior Alto C & E');
              })
            : ControlesWidget(Icons.arrow_drop_up, 110, null), // controle cima
        // row para criar os botões esquerda, grab e direita
        _servoSelecionado == ServoAtivo.Inferior
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ControlesWidget(Icons.arrow_left, 110, () {
                    widget.channel.write('b');
                    print('Inferior B');
                  }), // controle esquerda
                  ControlesWidget(Icons.radio_button_unchecked, 100, () {
                    widget.channel.write('g');
                    print('Garra/Grab');
                  }), // controle grab
                  ControlesWidget(Icons.arrow_right, 110, () {
                    widget.channel.write('a');
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
                      widget.channel.write('G');
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
                widget.channel.write('d');
                widget.channel.write('f');
                print('Inferior Baixo D & F');
              })
            : ControlesWidget(Icons.arrow_drop_down, 110, null),

        _isLive == false
            ? Text('')
            :
            // slider de velocidade
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
        _isLive == false
            ? Text('')
            : Container(
                height: 150,
                width: 300,
                child: Card(
                  child: ListaComandos(),
                ),
              ),
      ],
    );
  }

  Widget mainScreenNull() {
    return Column(
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
        ControlesWidget(Icons.arrow_drop_up, 110, null), // controle cima
        // row para criar os botões esquerda, grab e direita
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ControlesWidget(Icons.arrow_left, 110, null), // controle esquerda
            ControlesWidget(
                Icons.radio_button_unchecked, 100, null), // controle grab
            ControlesWidget(Icons.arrow_right, 110, null), // controle direita
          ],
        ), // fim row
        // controle down
        ControlesWidget(Icons.arrow_drop_down, 110, null),
        // slider de velocidade
      ],
    );
  }
}
