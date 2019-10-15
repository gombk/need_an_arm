import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import './tela_principal.dart';
import '../widgets/drawer.dart';

class ConnectionScreen extends StatefulWidget {
  static const routeName = '/connection-screen';

  @override
  _ConnectionScreenState createState() => _ConnectionScreenState();
}

class _ConnectionScreenState extends State<ConnectionScreen> with ChangeNotifier {
  final _ipController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Conectar ao Socket'),
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextFormField(
              autocorrect: false,
              autofocus: true,
              decoration: const InputDecoration(labelText: 'Insira o IP'),
              keyboardType: TextInputType.text,
              controller: _ipController,
              onFieldSubmitted: (_) {},
              validator: (value) {
                if (value.isEmpty) {
                  return 'Por favor, insira um IP';
                }
                return null;
              },
            ),
            Flexible(
              flex: 2,
              child: RaisedButton(
                color: Colors.blue,
                elevation: 4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
                child: Text(
                  'Conectar',
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  _submitIP();
                  Navigator.of(context).pushNamed(TelaPrincipal.routeName);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _submitIP() {
    if (_ipController.text.isEmpty) {
      print('$_ipController está vazio');
      return;
    }

    final enteredIP = _ipController.text;

    if (enteredIP.isEmpty) {
      print('$enteredIP está vazio');
      return;
    }

    _tryConnect(enteredIP);
  }

  void _tryConnect(String host) async {
    try {
      print('Tentando conectar em $host...');
      Socket s = await Socket.connect(host, 80);
      TelaPrincipal(channel: s,);
      notifyListeners();
      print('Conectado com sucesso em $host');
    } catch (e) {
      print('Falha ao conectar-se em $host\n$e');
    }
  }
}
