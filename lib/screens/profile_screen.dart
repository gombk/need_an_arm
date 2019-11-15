import 'package:flutter/material.dart';

import '../widgets/drawer.dart';
import '../widgets/profile_grid.dart';

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
      drawer: AppDrawer(),
      body: Center(
        child: ProfileGrid(),
      ),
    );
  }
}
