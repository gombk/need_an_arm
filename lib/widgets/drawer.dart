import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../screens/help_screen.dart';
import '../screens/options_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/tela_principal.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Need an arm'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.control_point_duplicate),
            title: Text('Controlador'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(TelaPrincipal.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.format_list_numbered),
            title: Text('Perfis'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(ProfileScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(FontAwesomeIcons.edit),
            title: Text('Opções'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(OptionsScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(FontAwesomeIcons.question),
            title: Text('Como usar/Sobre'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(HelpScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
