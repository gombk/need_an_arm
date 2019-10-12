import 'package:flutter/material.dart';

import '../widgets/drawer.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = '/Profile-Screen';

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfis'),
      ),
      body: Center(
        child: Text('Perfis'),
      ),
      drawer: AppDrawer(),
    );
  }
}
