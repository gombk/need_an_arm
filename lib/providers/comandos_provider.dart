import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../models/Perfil.dart';
import '../models/comandos.dart';

class ComandosProvider with ChangeNotifier {
  Socket socket;
  bool _isConnected = false;
  String _servo;
  bool _isRecording = false;
  bool isOpen = true;
  List<Comandos> _comandos = [];
  List<Perfil> _perfil = [];
  int _precisionValue = 0;
  int _delayValue = 0;
  int _angServo = 0;

  // GETTERS START
  List<Comandos> get cmd => [..._comandos];

  List<Perfil> get perfil => [..._perfil];

  String get servoComando => _servo;

  int get angServo => _angServo;

  bool get connected => _isConnected;

  int get precisionValue => _precisionValue;

  int get delayValue => _delayValue;

  // GETTERS END

  void changeMode() {
    _isRecording = !_isRecording;

    notifyListeners();
  }

  void resetComando() {
    _comandos.clear();

    notifyListeners();
  }

  void addProfile() {
    _perfil.insert(
      0,
      Perfil(
        id: 0,
        name: 'Teste',
      ),
    );

    notifyListeners();
  }

  void calcAngServo({String servo, String direcao, int precisao, int delay}) {
    // ############## Servo 1 START ##############
    if (servo == 'S1' && direcao == 'D') {
      _angServo += precisao;
      _delayValue = delay;

      if (_angServo >= 180) {
        _angServo = 180;
      }

      if (_isRecording) {
        _comandos.add(
          Comandos(
            // id: ,
            tipo: 'W',
            servo: 'A',
            angulo: _angServo,
            delay: delay,
          ),
        );

        _servo = 'W:A:$_angServo:$precisao';
      } else {
        _comandos.add(
          Comandos(
            // id: ,
            servo: 'A',
            angulo: _angServo,
            delay: delay,
          ),
        );
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
        _comandos.add(
          Comandos(
            // id: ,
            tipo: 'W',
            servo: 'A',
            angulo: _angServo,
            delay: delay,
          ),
        );

        _servo = 'W:A:$_angServo:$precisao';
      } else {
        _comandos.add(
          Comandos(
            // id: ,
            servo: 'A',
            angulo: _angServo,
            delay: delay,
          ),
        );
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
        _servo = 'W:C:$_angServo:$precisao';
        _comandos.add(
          Comandos(
            // id: ,
            tipo: 'W',
            servo: 'C',
            angulo: _angServo,
            delay: delay,
          ),
        );
      } else {
        _comandos.add(
          Comandos(
            // id: ,
            servo: 'C',
            angulo: _angServo,
            delay: delay,
          ),
        );
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
        _comandos.add(
          Comandos(
            // id: ,
            tipo: 'W',
            servo: 'C',
            angulo: _angServo,
            delay: delay,
          ),
        );
        _servo = 'W:C:$_angServo:$precisao';
      } else {
        _comandos.add(
          Comandos(
            // id: ,
            servo: 'C',
            angulo: _angServo,
            delay: delay,
          ),
        );
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
        _comandos.add(
          Comandos(
            // id: ,
            tipo: 'W',
            servo: 'D',
            angulo: _angServo,
            delay: delay,
          ),
        );
        _servo = 'W:D:$_angServo:$precisao';
      } else {
        _comandos.add(
          Comandos(
            // id: ,
            servo: 'D',
            angulo: _angServo,
            delay: delay,
          ),
        );
        _servo = 'D:$_angServo:$precisao';
      }

      print(_servo);
    }

    if (servo == 'S3' && direcao == 'DOWN') {
      _angServo -= precisao;

      if (_angServo <= 0) {
        _angServo = 0;
      }

      if (_isRecording) {
        _comandos.add(
          Comandos(
            // id: ,
            tipo: 'W',
            servo: 'D',
            angulo: _angServo,
            delay: delay,
          ),
        );
        _servo = 'W:D:$_angServo:$precisao';
      } else {
        _comandos.add(
          Comandos(
            // id: ,
            servo: 'D',
            angulo: _angServo,
            delay: delay,
          ),
        );
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
      socket = await Socket.connect(host, 80);

      _isConnected = true;

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
    // print(new String.fromCharCodes(data).trim());
  }

  void errorHandler(error, StackTrace trace) {
    print(error);
  }

  void doneHandler() {
    socket.destroy();
  }
}
