import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../providers/comandos_provider.dart';
import '../widgets/drawer.dart';

class OptionsScreen extends StatefulWidget {
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
            optionsBlueprint('Tema escuro', _darkTheme, (bool newValue) {
              setState(() {
                _darkTheme = !_darkTheme;
                newValue = _darkTheme;
              });
            }),
            optionsBlueprint('Fixar IP', _fixateIP, (bool newValue) {
              setState(() {
                _fixateIP = !_fixateIP;
                newValue = _fixateIP;
              });
            }),
            _fixateIP
                ? Card(
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        autocorrect: false,
                        autofocus: true,
                        decoration:
                            const InputDecoration(labelText: 'Insira um IP'),
                        keyboardType: TextInputType.text,
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
                  )
                : Column(),
            optionsBlueprint('Trocar porta', _changePort, (bool newValue) {
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
          Fluttertoast.showToast(msg: 'TODO: Salvar opções');
        },
      ),
    );
  }

  Widget optionsBlueprint(String title, bool switchValue, Function switchKey) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(title),
            Switch(
              value: switchValue,
              onChanged: switchKey,
            ),
          ],
        ),
      ),
    );
  }
}
