import 'package:flutter/material.dart';

class ControlesWidget extends StatelessWidget {
  final IconData icone;
  final double tamanho;
  final Function funcao;

  ControlesWidget(this.icone, this.tamanho, this.funcao);

  @override
  Widget build(BuildContext context) {
    // TO DO: Implementar um gesture detector para reconhecer o botão segurado
    return IconButton(
      icon: Icon(icone),
      iconSize: tamanho,
      onPressed: funcao,
    );
  }
}
