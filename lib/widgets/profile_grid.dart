import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'profile_item.dart';

import '../providers/comandos_provider.dart';
import '../models/comandos.dart';

class ProfileGrid extends StatelessWidget {
  List<Comandos> cmd = [
    Comandos(
      id: 0,
      angulo: 10,
      delay: 4,
      servo: 'A',
      tipo: 'W',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final comandosData = Provider.of<ComandosProvider>(context);
    final comandos = comandosData.cmd;

    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: 1, // comandos.length
      itemBuilder: (ctx, i) => Center(
        child: ProfileItem(),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
