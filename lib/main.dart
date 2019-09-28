import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/tela_principal.dart';
import './screens/splash_screen.dart';
import './providers/comandos_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
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
          TelaPrincipal.routeName: (ctx) => TelaPrincipal(),
        },
      ),
    );
  }
}
