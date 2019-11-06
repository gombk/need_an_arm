import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../providers/settings_provider.dart';
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

  String _ip = '';
  String _port = '';

  final portController = TextEditingController();
  final ipController = TextEditingController();
  final _formIPKey = GlobalKey<FormState>();
  final _formPortKey = GlobalKey<FormState>();

  @override
  void initState() {
    Future.delayed(Duration.zero).then((onValue) {
      Provider.of<SettingsProvider>(context).getIp().then(getIp);
      Provider.of<SettingsProvider>(context).getPort().then(getPort);
      Provider.of<SettingsProvider>(context).switchIp().then(updateIpSwitch);
      Provider.of<SettingsProvider>(context)
          .switchPort()
          .then(updatePortSwitch);
    });
    super.initState();
  }

  void getIp(String ip) {
    setState(() {
      _ip = ip;
    });
  }

  void getPort(String port) {
    setState(() {
      _port = port;
    });
  }

  void updateIpSwitch(bool fixIp) {
    setState(() {
      _fixateIP = fixIp;
    });
  }

  void updatePortSwitch(bool fixPort) {
    setState(() {
      _changePort = fixPort;
    });
  }

  void saveValues() {
    if (_changePort && _fixateIP) if (_formIPKey.currentState.validate() &&
        _formPortKey.currentState.validate())
      Fluttertoast.showToast(msg: 'Opções salvas com sucesso');

    if (_fixateIP) if (_formIPKey.currentState.validate()) {
      Fluttertoast.showToast(msg: 'IP salvo com sucesso');
      Provider.of<SettingsProvider>(context).saveIp(ipController.text);
      print(ipController.text);
    }

    if (_changePort) if (_formPortKey.currentState.validate()) {
      Fluttertoast.showToast(msg: 'Porta salva com sucesso');
      Provider.of<SettingsProvider>(context).savePort(portController.text);
      print(portController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<SettingsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Opções'),
        actions: <Widget>[
          IconButton(
            icon: Icon(FontAwesomeIcons.save),
            onPressed: saveValues,
            
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
                  settings.saveSwitchIp(_fixateIP);
                }),
            _fixateIP
                ? Form(
                    key: _formIPKey,
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
                          validator: (value) {
                            String padraoIP =
                                r'(\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b)';
                            RegExp regExp = RegExp(padraoIP);

                            if (value.isEmpty) {
                              return 'Por favor, insira um IP';
                            } else if (!regExp.hasMatch(value)) {
                              return 'Insira um IP no padrão correto (ex: 1.1.1.1)';
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
                  settings.saveSwitchPort(_changePort);
                }),
            _changePort
                ? Card(
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                        key: _formPortKey,
                        child: TextFormField(
                          autocorrect: false,
                          autofocus: true,
                          decoration: const InputDecoration(
                              labelText: 'Insira a Porta'),
                          keyboardType: TextInputType.number,
                          controller: portController,
                          validator: (value) {
                            String padraoPorta = r'(\b\d{1,4}\b)';
                            RegExp regExp = RegExp(padraoPorta);

                            if (value.isEmpty) {
                              return 'Por favor, insira uma porta';
                            } else if (!regExp.hasMatch(value)) {
                              return 'Apenas números são aceitos';
                            }
                            return null;
                          },
                        ),
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
        onPressed: saveValues,
      ),
    );
  }
}
