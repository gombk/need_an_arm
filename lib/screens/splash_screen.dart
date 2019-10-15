import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';

import './tela_principal.dart';
import './connection_screen.dart';

// https://www.2dimensions.com/a/rickseifarth/files/flare/robot-arm/preview

class SplashScreen extends StatefulWidget {
  static const routeName = '/';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Flexible(
            flex: 4,
            child: Text(
              'Need an Arm?',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Flexible(
            flex: 8,
            child: FlareActor(
              'assets/flare/robotic_arm.flr',
              alignment: Alignment.center,
              fit: BoxFit.contain,
              // animation: 'machine',
            ),
          ),
          Flexible(
            flex: 2,
            child: RaisedButton(
              color: Colors.white,
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
              child: Text(
                'Continuar',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () => Navigator.of(context)
                  .pushReplacementNamed(TelaPrincipal.routeName),
            ),
          ),
          Flexible(
            flex: 2,
            child: RaisedButton(
              color: Colors.white,
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
              child: Text(
                'Conexão',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () => Navigator.of(context)
                  .pushReplacementNamed(ConnectionScreen.routeName),
            ),
          ),
        ],
      ),
    );
  }
}
