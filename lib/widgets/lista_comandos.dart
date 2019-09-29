import 'package:flutter/material.dart';

class ListaComandos extends StatefulWidget {
  @override
  _ListaComandosState createState() => _ListaComandosState();
}

class _ListaComandosState extends State<ListaComandos> {
  List<Map<String, int>> comandos;
  Key key;

  Widget texto(List<Map<String, int>> comando) {
    return Text(
      '$comando',
      style: TextStyle(
        fontSize: 20,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (ctx, i) {
        return Column(
          children: <Widget>[
            Dismissible(
              child: texto([
                {'a': 0}
              ]),
              background: Container(
                child: Icon(
                  Icons.delete,
                  color: Theme.of(context).errorColor,
                ),
                alignment: Alignment.centerRight,
              ),
              direction: DismissDirection.endToStart,
              key: ValueKey(DateTime.now()),
              confirmDismiss: (direcao) {
                return showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text('Você tem certeza??'),
                    content: Text('Você quer remover o comando?'),
                    actions: <Widget>[
                      FlatButton(
                        child: Text('Não'),
                        onPressed: () {
                          Navigator.of(ctx).pop(false);
                        },
                      ),
                      FlatButton(
                        child: Text('Sim'),
                        onPressed: () {
                          Navigator.of(ctx).pop(true);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        );
      },
      itemCount: 1,
    );
  }
}
