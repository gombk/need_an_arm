import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/comandos_provider.dart';

class ConnectionWidget extends StatefulWidget {
  final TextEditingController ipController;
  final TextEditingController portController;
  final Function submitIp;

  ConnectionWidget({this.ipController, this.submitIp, this.portController});

  @override
  _ConnectionWidgetState createState() => _ConnectionWidgetState();
}

class _ConnectionWidgetState extends State<ConnectionWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
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
            controller: widget.ipController,
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
              onPressed: widget.submitIp,
            ),
          ),
        ],
      ),
    );
  }
}
