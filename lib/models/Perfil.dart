import 'package:flutter/foundation.dart';

class Perfil {
  final String id;
  final String name;
  bool isFavorite;

  Perfil({
    @required this.id,
    @required this.name,
    this.isFavorite = false,
  });
}
