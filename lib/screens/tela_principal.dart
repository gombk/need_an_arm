import 'dart:io';

import 'package:flutter/material.dart';

import '../widgets/controles.dart';
import '../widgets/servos.dart';
import '../widgets/lista_comandos.dart';
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

  void _enviaComando() {
    widget.channel.write("TESTE\n");
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
                child: ButtonServoWidget(() {}, 'Inferior'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ButtonServoWidget(() {}, 'Superior'),
              ),
            ],
          ),
          ControlesWidget(Icons.arrow_drop_up, 110, () {}), // controle cima
          // row para criar os botões esquerda, grab e direita
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ControlesWidget(Icons.arrow_left, 110, () {
                Comandos({'A': 0});
              }), // controle esquerda
              ControlesWidget(Icons.radio_button_unchecked, 100,
                  _enviaComando), // controle grab
              ControlesWidget(Icons.arrow_right, 110, () {
                Comandos({'B': 0});
              }), // controle direita
            ],
          ), // fim row
          // controle down
          ControlesWidget(Icons.arrow_drop_down, 110, () {}),
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
          Container(
            height: 150,
            width: 300,
            child: Card(
              child: ListaComandos(),
            ),
          ),
        ],
      ),
      // FAB que irá realizar a função de gravar
      // TO DO: se estiver gravando o FAB irá mudar para parar a gravação
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_box),
        // o método onPressed irá abrir um diálogo perguntar se quer começar a gravação
        onPressed: () => showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Gravar comandos'),
            content: Text('Você deseja começar a gravar os seus comandos?'),
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
                  Navigator.of(ctx).pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
