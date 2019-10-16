import 'package:flutter/material.dart';

import '../screens/recording_screen.dart';

class FabGravar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                  child: Text('Não'),
                  onPressed: () {
                    print('Não gravar');
                    Navigator.of(ctx).pop();
                  },
                ),
                FlatButton(
                  child: Text('Sim'),
                  onPressed: () {
                    print('Gravando');
                    Navigator.of(ctx).pop();
                    Navigator.of(context).pushNamed(RecordingScreen.routeName);
                  },
                ),
              ],
            ),
          );
        });
  }
}
