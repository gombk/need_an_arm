import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/tela_principal.dart';
import './screens/splash_screen.dart';
import './screens/help_screen.dart';
import './screens/options_screen.dart';
import './screens/profile_screen.dart';

import './providers/comandos_provider.dart';

void main() async {
  Socket sock = await Socket.connect('192.168.0.1', 80);

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
          primaryColor: Colors.blue,
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (ctx) => SplashScreen(),
          TelaPrincipal.routeName: (ctx) => TelaPrincipal(
                channel: socket,
              ),
          ProfileScreen.routeName: (ctx) => ProfileScreen(),
          OptionsScreen.routeName: (ctx) => OptionsScreen(),
          HelpScreen.routeName: (ctx) => HelpScreen(),
        },
      ),
    );
  }
}
