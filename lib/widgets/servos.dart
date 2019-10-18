import 'package:flutter/material.dart';

class ButtonServoWidget extends StatelessWidget {
  final Function trocaServo;
  final String nomeServo;

  ButtonServoWidget(this.trocaServo, this.nomeServo);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: Theme.of(context).accentColor,
      child: Text(nomeServo, style: TextStyle(color: Colors.black),),
      onPressed: trocaServo,
    );
  }
}
