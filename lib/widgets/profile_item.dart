import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../models/perfil.dart';

class ProfileItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<Perfil>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Fluttertoast.showToast(msg: '${profile.id}');
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
          title: Text('Perfil ${profile.id}', textAlign: TextAlign.center),
        ),
      ),
    );
  }
}
