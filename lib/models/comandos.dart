import 'package:flutter/material.dart';

class Comandos with ChangeNotifier {
  List<String> comandos;

  List<String> get cmd {
    return comandos;
  }

  void addComando(String value) {
    comandos.add(value);

    notifyListeners();
  }
}