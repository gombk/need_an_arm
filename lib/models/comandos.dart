import 'package:flutter/foundation.dart';

class Comandos {
  // final Map<String, int> comandos;
  final Function servoInfDireito;
  final Function servoInfEsquerdo;
  final Function servoSupCima;
  final Function servoSupBaixo;
  final Function grab;

  Comandos({
    this.grab,
    this.servoInfDireito,
    this.servoInfEsquerdo,
    this.servoSupBaixo,
    this.servoSupCima,
  });
}
