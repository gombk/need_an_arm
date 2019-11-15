import 'package:flutter/foundation.dart';

class Comandos with ChangeNotifier {
  final String tipo;
  final String servo;
  final int id;
  final int angulo;
  final int delay;

  Comandos({this.id, this.servo, this.angulo, this.tipo, this.delay});
}
