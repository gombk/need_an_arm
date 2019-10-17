import 'package:flutter/foundation.dart';

class Perfil {
  final String id;
  final String name;
  final Map<String, int> commandToSend;
  bool isActive;

  Perfil({
    @required this.id,
    @required this.name,
    @required this.commandToSend,
    this.isActive = false,
  });
}