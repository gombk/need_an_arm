import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ComandosProvider with ChangeNotifier {
  Socket _socket;
  bool isConnected;
  int _angServo = 0;
  String _servo;
  bool _isRecording = false;
  bool isOpen = true;
  List<String> comandos = [];

  List<String> get cmd {
    return comandos;
  }

  Socket get socket {
    return _socket;
  }

  String get servoComando {
    return _servo;
  }

  int get angServo {
    return _angServo;
  }

  bool get connected {
    return isConnected;
  }

  /* função de teste por que eu simplesmente posso adicionar o valor em uma das funções abaixo :)
  mas quando eu fiz isso achei que era assim que tinha que fazer, mas pensando bem é apenas desperdício
  de recurso xD
  */
  void addComando(String value) {
    comandos.add(value);

    notifyListeners();
  }
  // fim da função de teste

  void changeMode() {
    _isRecording = !_isRecording;

    notifyListeners();
  }

  void resetComando() {
    comandos.removeWhere((comandos) => comandos.length > 0);

    notifyListeners();
  }

  void calcAngServo(String servo, String direcao, int precisao) {
    if (servo == 'S1' && direcao == 'D') {
      _angServo += precisao;

      if (_angServo >= 180) {
        _angServo = 180;
      }

      if (_isRecording) {
        comandos.add('W:A:$_angServo:$precisao');
      } else {
        _servo = 'A:$_angServo:$precisao';
      }

      print(_servo);
    }

    if (servo == 'S1' && direcao == 'E') {
      _angServo -= precisao;

      if (_angServo <= 0) {
        _angServo = 0;
      }
      _servo = 'A:$_angServo:$precisao';
      print(_servo);
    }

    if (servo == 'S2' && direcao == 'UP') {
      _angServo += precisao;

      if (_angServo >= 180) {
        _angServo = 180;
      }

      if (_isRecording) {
        comandos.add('W:C:$_angServo:$precisao');
      } else {
        _servo = 'C:$_angServo:$precisao';
      }

      _servo = 'C:$_angServo:$precisao';
      print(_servo);
    }

    if (servo == 'S2' && direcao == 'DOWN') {
      _angServo -= precisao;

      if (_angServo <= 0) {
        _angServo = 0;
      }

      _servo = 'C:$_angServo:$precisao';
      print(_servo);
    }

    if (servo == 'S3' && direcao == 'UP') {
      _angServo += precisao;

      if (_angServo >= 180) {
        _angServo = 180;
      }

      _servo = 'D:$_angServo:$precisao';
      print(_servo);
    }

    if (servo == 'S3' && direcao == 'DOWN') {
      _angServo -= precisao;

      if (_angServo <= 0) {
        _angServo = 180;
      }

      _servo = 'D:$_angServo:$precisao';
      print(_servo);
    }
  }

  void garra() {
    if (isOpen) {
      _servo = 'G:180:0';
      print("$_servo\n$isOpen");
      isOpen = false;
    } else if (isOpen == false) {
      _servo = 'G:0:0';
      print("$_servo\n$isOpen");
      isOpen = true;
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
