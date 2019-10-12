import 'package:flutter/material.dart';

import '../widgets/drawer.dart';

class OptionsScreen extends StatelessWidget {
  static const routeName = '/options-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Opções'),
      ),
      body: Center(
        child: Text('Opções'),
      ),
      drawer: AppDrawer(),
    );
  }
}
