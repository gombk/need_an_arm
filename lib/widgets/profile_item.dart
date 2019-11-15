import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../models/comandos.dart';

class ProfileItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cmd = Provider.of<Comandos>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Fluttertoast.showToast(msg: '${cmd.id}');
          },
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.bottomRight,
                stops: [0.1, 0.3, 0.5, 0.9],
                colors: [
                  const Color(0xFFe1fff8), // 0.1
                  const Color(0xFFb6ffee), // 0.3
                  const Color(0xFF93ffe5), // 0.5
                  const Color(0xFF64FFDA), // 0.9
                ],
              ),
            ),
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          title: Text('Perfil ${cmd.id}', textAlign: TextAlign.center),
        ),
      ),
    );
  }
}
