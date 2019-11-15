import 'package:flutter/foundation.dart';

class Perfil with ChangeNotifier {
  final int id;
  final String name;
  bool isActive;

  Perfil({
    this.id,
    this.name,
    this.isActive = false,
  });
}
