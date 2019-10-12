import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';

import './screens/tela_principal.dart';
import './screens/splash_screen.dart';
import './providers/comandos_provider.dart';

void main() async {
  Socket sock = await Socket.connect('172.20.10.2', 80);

  runApp(MyApp(sock));
}

class MyApp extends StatelessWidget {
  Socket socket;

  MyApp(Socket s) {
    this.socket = s;
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
          TelaPrincipal.routeName: (ctx) => TelaPrincipal(
                channel: socket,
              ),
        },
      ),
    );
  }
}
