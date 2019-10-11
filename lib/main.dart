import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';

import './screens/tela_principal.dart';
import './screens/splash_screen.dart';
import './providers/comandos_provider.dart';

void main() async {
  Socket sock = await Socket.connect('162.168.0.110', 80);
  runApp(MyApp(sock));
}

class MyApp extends StatelessWidget {
  Socket sockect;

  MyApp(Socket s) {
    this.sockect = s;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (ctx) => ComandosProvider(),
      child: MaterialApp(
        title: 'Need an Arm',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (ctx) => SplashScreen(),
          TelaPrincipal.routeName: (ctx) => TelaPrincipal(channel: sockect,),
        },
      ),
    );
  }
}
