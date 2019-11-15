import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';

import './controller_screen.dart';

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
      // backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () => Navigator.of(context)
            .pushReplacementNamed(ControllerScreen.routeName),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Flexible(
              flex: 4,
              child: Text(
                'Need an Arm?',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Flexible(
                flex: 8,
                child:
                    Image.asset('assets/images/robotic.png', fit: BoxFit.cover)
                // FlareActor(
                //   'assets/flare/robotic_arm.flr',
                //   alignment: Alignment.center,
                //   fit: BoxFit.contain,
                //   // animation: 'machine',
                // ),
                ),
            Flexible(
              flex: 2,
              child: RaisedButton(
                color: Colors.black,
                elevation: 4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
                child: Text(
                  'Continuar',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () => Navigator.of(context)
                    .pushReplacementNamed(ControllerScreen.routeName),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
