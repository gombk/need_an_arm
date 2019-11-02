import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/recording_screen.dart';
import '../providers/comandos_provider.dart';

class FabGravar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final changeMode = Provider.of<ComandosProvider>(context);

    return FloatingActionButton(
      child: Icon(Icons.play_circle_outline),
      // o método onPressed irá abrir um diálogo perguntar se quer começar a gravação
      onPressed: () {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Gravar comandos'),
            content: Text('Você deseja começar a gravar os seus comandos?'),
            actions: <Widget>[
              FlatButton(
                child: Text('Não gravar'),
                onPressed: () {
                  print('Não gravar');
                  Navigator.of(ctx).pop();
                },
              ),
              FlatButton(
                child: Text('Sim'),
                onPressed: () {
                  print('Gravando');
                  changeMode.changeMode();
                  setValorSlidersDrawer();
                  Navigator.of(ctx).pop();
                  Navigator.of(context).pushNamed(RecordingScreen.routeName);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

Future<bool> setValorSlidersDrawer() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setInt('precision', 0);
  prefs.setInt('delay', 0);

  return prefs.commit();
}
