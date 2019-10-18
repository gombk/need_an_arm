import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ComandosProvider with ChangeNotifier {
  Socket _socket;
  bool isConnected;
  bool isReallyReallyConnected;

  Socket get socket {
    return _socket;
  }

  bool get connected {
    return isReallyReallyConnected;
  }

  void isReallyConnected() {
    if (isConnected) {
      isReallyReallyConnected = true;
    }
  }

  void connect(String host) async {
    try {
      print('Trying to connect');

      Fluttertoast.showToast(
        msg: 'Tentando conectar em $host',
        toastLength: Toast.LENGTH_SHORT,
      );

      _socket = await Socket.connect(host, 80);
      isConnected = true;

      print('Conectado com sucesso');
      Fluttertoast.showToast(
        msg: 'Conectado com sucesso em $host',
        toastLength: Toast.LENGTH_SHORT,
      );
      isReallyConnected();

      notifyListeners();
    } catch (e) {
      print('Falha ao conectar-se em $host\n$e');
      Fluttertoast.showToast(
        msg: 'Falha ao tentar se conectar em $host',
        backgroundColor: Colors.red,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_LONG,
      );
    }
  }
}
