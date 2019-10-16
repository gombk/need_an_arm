import 'package:flutter/material.dart';

class ConnectionWidget extends StatelessWidget {
  final TextEditingController ipController;
  final Function submitIp;

  ConnectionWidget({this.ipController, this.submitIp});

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
            controller: ipController,
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
              onPressed: submitIp,
            ),
          ),
        ],
      ),
    );
  }
}
