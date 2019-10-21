import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ComandosProvider with ChangeNotifier {
  Socket socket;
  bool _isConnected = false;
  int _angServo = 0;
  String _servo;
  bool _isRecording = false;
  bool isOpen = true;
  List<String> comandos = [];

  List<String> get cmd {
    return comandos;
  }

  String get servoComando {
    return _servo;
  }

  int get angServo {
    return _angServo;
  }

  bool get connected {
    return _isConnected;
  }

  void changeMode() {
    _isRecording = !_isRecording;

    notifyListeners();
  }

  void resetComando() {
    comandos.removeWhere((comandos) => comandos.length > 0);

    notifyListeners();
  }

  void calcAngServo(String servo, String direcao, int precisao) {
    // ############## Servo 1 START ##############
    if (servo == 'S1' && direcao == 'D') {
      _angServo += precisao;

      if (_angServo >= 180) {
        _angServo = 180;
      }

      if (_isRecording) {
        comandos.add('W:A:$_angServo:$precisao');
        _servo = 'A:$_angServo:$precisao';
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

      if (_isRecording) {
        comandos.add('W:A:$_angServo:$precisao');
        _servo = 'A:$_angServo:$precisao';
      } else {
        _servo = 'A:$_angServo:$precisao';
      }

      print(_servo);
    }
    // ############## Servo 1 END ##############

    // #########################################

    // ############## Servo 2 START ############

    if (servo == 'S2' && direcao == 'UP') {
      _angServo += precisao;

      if (_angServo >= 180) {
        _angServo = 180;
      }

      if (_isRecording) {
        comandos.add('W:C:$_angServo:$precisao');
        _servo = 'W:C:$_angServo:$precisao';
      } else {
        _servo = 'C:$_angServo:$precisao';
      }

      print(_servo);
    }

    if (servo == 'S2' && direcao == 'DOWN') {
      _angServo -= precisao;

      if (_angServo <= 0) {
        _angServo = 0;
      }

      if (_isRecording) {
        comandos.add('W:C:$_angServo:$precisao');
        _servo = 'W:C:$_angServo:$precisao';
      } else {
        _servo = 'C:$_angServo:$precisao';
      }

      print(_servo);
    }

    // ############## Servo 2 END ##############

    // #########################################

    // ############## Servo 3 START ############
    if (servo == 'S3' && direcao == 'UP') {
      _angServo += precisao;

      if (_angServo >= 180) {
        _angServo = 180;
      }

      if (_isRecording) {
        comandos.add('W:D:$_angServo:$precisao');
        _servo = 'W:D:$_angServo:$precisao';
      } else {
        _servo = 'D:$_angServo:$precisao';
      }
      
      print(_servo);
    }

    if (servo == 'S3' && direcao == 'DOWN') {
      _angServo -= precisao;

      if (_angServo <= 0) {
        _angServo = 180;
      }

      if (_isRecording) {
        comandos.add('W:D:$_angServo:$precisao');
        _servo = 'W:D:$_angServo:$precisao';
      } else {
        _servo = 'D:$_angServo:$precisao';
      }

      print(_servo);
    }

    // ############## Servo 3 END ##############

    // #########################################
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

      socket = await Socket.connect(host, 80).then((Socket sock) {
        _isConnected = true;
        socket = sock;
        socket.listen(dataHandler,
            onError: errorHandler, onDone: doneHandler, cancelOnError: false);
      }).catchError((AsyncError e) {
        print("Não foi possível conectar em $host:80\nErro: $e");
      });

      print('Conectado com sucesso');
      Fluttertoast.showToast(
        msg: 'Conectado com sucesso em $host:80',
        toastLength: Toast.LENGTH_SHORT,
        textColor: Colors.white,
        backgroundColor: Colors.green,
      );
    } catch (e) {
      print('Falha ao conectar-se em $host\n$e');
      Fluttertoast.showToast(
        msg: 'Falha ao tentar se conectar em $host:80',
        backgroundColor: Colors.red,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_LONG,
      );
      _isConnected = false;
    }
    notifyListeners();
  }

  void dataHandler(data) {
    print(new String.fromCharCodes(data).trim());
  }

  void errorHandler(error, StackTrace trace) {
    print(error);
  }

  void doneHandler() {
    socket.destroy();
  }
}
