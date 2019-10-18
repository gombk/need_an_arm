import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

import './screens/tela_principal.dart';
import './screens/splash_screen.dart';
import './screens/help_screen.dart';
import './screens/options_screen.dart';
import './screens/profile_screen.dart';
import './screens/recording_screen.dart';

import './providers/comandos_provider.dart';

void main() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (ctx) => ComandosProvider(),
      child: MaterialApp(
        title: 'Need an Arm',
        theme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.blue,
          primaryColor: const Color(0xFF212121),
          accentColor: const Color(0xFF64ffda),
          canvasColor: const Color(0xFF303030),
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (ctx) => SplashScreen(),
          TelaPrincipal.routeName: (ctx) => TelaPrincipal(),
          RecordingScreen.routeName: (ctx) => RecordingScreen(
                channel: null,
              ),
          ProfileScreen.routeName: (ctx) => ProfileScreen(),
          OptionsScreen.routeName: (ctx) => OptionsScreen(),
          HelpScreen.routeName: (ctx) => HelpScreen(),
        },
      ),
    );
  }
}
