import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/comandos_provider.dart';

class ListaComandos extends StatefulWidget {
  @override
  _ListaComandosState createState() => _ListaComandosState();
}

class _ListaComandosState extends State<ListaComandos> {
  Key key;

  @override
  Widget build(BuildContext context) {
    final cmdProvider = Provider.of<ComandosProvider>(context);

    return ListView.builder(
      itemBuilder: (ctx, i) {
        return Column(
          children: <Widget>[
            Dismissible(
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text(
                  '${cmdProvider.comandos[i]}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
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
                    title: Text('Você tem certeza?'),
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
      itemCount: cmdProvider.cmd.length,
    );
  }
}
