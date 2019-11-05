import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../providers/comandos_provider.dart';
import '../widgets/drawer.dart';
import '../widgets/options_card.dart';

class OptionsScreen extends StatefulWidget {
  OptionsScreen({Key key}) : super(key: key);

  static const routeName = '/options-screen';

  @override
  _OptionsScreenState createState() => _OptionsScreenState();
}

class _OptionsScreenState extends State<OptionsScreen> {
  bool _darkTheme = false;
  bool _fixateIP = false;
  bool _changePort = false;
  TextEditingController portController;
  TextEditingController ipController;
  GlobalKey _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final optionsProvider = Provider.of<ComandosProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Opções'),
        actions: <Widget>[
          IconButton(
            icon: Icon(FontAwesomeIcons.save),
            onPressed: () {
              Fluttertoast.showToast(msg: 'Preferências salvas');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            OptionsCard(
                title: 'Tema escuro', switchValue: _darkTheme, switchKey: null),
            OptionsCard(
                title: 'Fixar IP',
                switchValue: _fixateIP,
                switchKey: (bool newValue) {
                  setState(() {
                    _fixateIP = !_fixateIP;
                    newValue = _fixateIP;
                  });
                }),
            _fixateIP
                ? Form(
                    key: _formKey,
                    child: Card(
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          autocorrect: false,
                          autofocus: true,
                          decoration:
                              const InputDecoration(labelText: 'Insira um IP'),
                          keyboardType: TextInputType.numberWithOptions(),
                          controller: ipController,
                          onFieldSubmitted: (_) {},
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Por favor, insira uma IP';
                            }
                            return null;
                          },
                        ),
                      ),
                    ))
                : Column(),
            OptionsCard(
                title: 'Trocar porta',
                switchValue: _changePort,
                switchKey: (bool newValue) {
                  setState(() {
                    _changePort = !_changePort;
                    newValue = _changePort;
                  });
                }),
            _changePort
                ? Card(
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        autocorrect: false,
                        autofocus: true,
                        decoration:
                            const InputDecoration(labelText: 'Insira a Porta'),
                        keyboardType: TextInputType.number,
                        controller: portController,
                        onFieldSubmitted: (_) {},
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Por favor, insira uma porta';
                          }
                          return null;
                        },
                      ),
                    ),
                  )
                : Column(),
          ],
        ),
      ),
      drawer: AppDrawer(),
      floatingActionButton: FloatingActionButton(
        child: Icon(FontAwesomeIcons.save),
        onPressed: () {
          saveIp(ipController.text);
        },
      ),
    );
  }
}

Future<bool> saveIp(String ip) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('ip', ip);

  return true;
}

Future<String> getIp() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  return prefs.getString('ip');
}
