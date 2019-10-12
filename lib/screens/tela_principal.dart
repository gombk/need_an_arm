import 'dart:io';

import 'package:flutter/material.dart';

import '../widgets/controles.dart';
import '../widgets/servos.dart';
import '../widgets/lista_comandos.dart';
import '../widgets/drawer.dart';
import '../models/comandos.dart';
import '../providers/comandos_provider.dart';

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
  var _servoSelecionado = 0;
  bool _isLive = false;

  void _servoInfDireito() {
    widget.channel.write("a");
  }

  void _servoInfEsquerdo() {
    widget.channel.write("b");
  }

  void _servoSupCima() {
    widget.channel.write('c');
    widget.channel.write('e');
  }

  void _servoSupBaixo() {
    widget.channel.write('d');
    widget.channel.write('f');
  }

  void _grab() {
    widget.channel.write('g');
  }

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
      ),
      drawer: AppDrawer(),
      body: _servoSelecionado == 0 ? mainScreenNull() : mainScreenFunc(),
      // FAB que irá realizar a função de gravar
      // TO DO: se estiver gravando o FAB irá mudar para parar a gravação
      floatingActionButton: _isLive
          ? FloatingActionButton(
              child: Icon(Icons.stop),
              onPressed: () {
                print('stop');
                setState(() {
                  _isLive = false;
                });
              },
            )
          : FloatingActionButton(
              child: Icon(Icons.add_box),
              // o método onPressed irá abrir um diálogo perguntar se quer começar a gravação
              onPressed: () => showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: Text('Gravar comandos'),
                  content:
                      Text('Você deseja começar a gravar os seus comandos?'),
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
              ),
            ),
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
                  _servoSelecionado = 1;
                });
              }, 'Inferior'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ButtonServoWidget(() {
                setState(() {
                  _servoSelecionado = 2;
                });
              }, 'Superior'),
            ),
          ],
        ),
        _servoSelecionado == 2
            ? ControlesWidget(Icons.arrow_drop_up, 110, _servoSupCima)
            : ControlesWidget(Icons.arrow_drop_up, 110, null), // controle cima
        // row para criar os botões esquerda, grab e direita
        _servoSelecionado == 1
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ControlesWidget(Icons.arrow_left, 110,
                      _servoInfDireito), // controle esquerda
                  ControlesWidget(Icons.radio_button_unchecked, 100,
                      _grab), // controle grab
                  ControlesWidget(Icons.arrow_right, 110,
                      _servoInfEsquerdo), // controle direita
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ControlesWidget(
                      Icons.arrow_left, 110, null), // controle esquerda
                  ControlesWidget(Icons.radio_button_unchecked, 100,
                      _grab), // controle grab
                  ControlesWidget(
                      Icons.arrow_right, 110, null), // controle direita
                ],
              ), // fim row
        _servoSelecionado == 2
            ?
            // controle down
            ControlesWidget(Icons.arrow_drop_down, 110, _servoSupBaixo)
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
                  _servoSelecionado = 1;
                });
              }, 'Inferior'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ButtonServoWidget(() {
                setState(() {
                  _servoSelecionado = 2;
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
