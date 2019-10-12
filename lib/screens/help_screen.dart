import 'package:flutter/material.dart';

import '../widgets/drawer.dart';

class HelpScreen extends StatelessWidget {
  static const routeName = '/help-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Como usar/Sobre'),
      ),
      body: Center(
        child: Text('Como usar/Sobre'),
      ),
      drawer: AppDrawer(),
    );
  }
}
