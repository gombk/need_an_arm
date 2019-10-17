import 'dart:io';

import 'package:flutter/foundation.dart';

class ComandosProvider with ChangeNotifier {
  Socket _socket;
  bool isConnected;

  Socket get socket {
    return _socket;
  }

  bool get connected {
    return isConnected;
  }

  void connect(String host) async{
    try {
      _socket = await Socket.connect(host, 80);
      isConnected = true;
      print('Conectado com sucesso');
      notifyListeners();
    } catch (e) {
    }
  }
}
