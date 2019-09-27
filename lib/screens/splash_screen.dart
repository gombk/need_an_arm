import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';

// https://www.2dimensions.com/a/rickseifarth/files/flare/robot-arm/preview

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

const brightYellow = Color(0xFFFFD300);
const darkYellow = Color(0xFFFFB900);

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: brightYellow,
      body: Column(
        children: [
          Flexible(
            flex: 8,
            child: FlareActor(
              'assets/flare/bus.flr',
              alignment: Alignment.center,
              fit: BoxFit.contain,
              animation: 'driving',
            ),
          ),
          Flexible(
            flex: 2,
            child: RaisedButton(
              color: darkYellow,
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
              child: Text(
                'Continuar',
                style: TextStyle(color: Colors.black54),
              ),
              onPressed: () => Navigator.of(context).pushNamed('/'),
            ),
          ),
        ],
      ),
    );
  }
}