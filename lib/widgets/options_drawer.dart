import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../providers/settings_drawer_provider.dart';

class OptionsDrawer extends StatefulWidget {
  @override
  _OptionsDrawerState createState() => _OptionsDrawerState();
}

class _OptionsDrawerState extends State<OptionsDrawer> {
  int _sliderPrecisao = 0;
  int _sliderDelay = 0;
  int global = 0;

  @override
  void initState() {
    getPrecisionValue().then(valorPrecisao);
    getDelayValue().then(valorDelay);
    super.initState();
  }

  void valorPrecisao(int precisao) {
    setState(() {
      _sliderPrecisao = precisao;
    });
  }

  void valorDelay(int delay) {
    setState(() {
      _sliderDelay = delay;
    });
  }

  @override
  Widget build(BuildContext context) {
    final valueProvider = Provider.of<SettingsDrawerProvider>(context);
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Need an arm - Configurações'),
            automaticallyImplyLeading: false,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Precisão',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Divider(),
          Slider(
            activeColor: Colors.blueAccent,
            value: _sliderPrecisao.toDouble(),
            min: 0.0,
            max: 180.0,
            divisions: 180,
            label: '$_sliderPrecisao',
            onChanged: (double newValue) {
              setState(() {
                _sliderPrecisao = newValue.round();
                setPrecisionValue(_sliderPrecisao);
              });
            },
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Delay',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Divider(),
          Slider(
            activeColor: Colors.blueAccent,
            value: _sliderDelay.toDouble(),
            min: 0.0,
            max: 5000.0,
            divisions: 100,
            label: '$_sliderDelay',
            onChanged: (double newValue) {
              setState(() {
                _sliderDelay = newValue.round();
                setDelayValue(_sliderDelay);
              });
            },
          ),
        ],
      ),
    );
  }
}

Future<int> getPrecisionValue() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  return prefs.getInt('precision');
}

Future<int> getDelayValue() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  return prefs.getInt('delay');
}

Future<bool> setPrecisionValue(int precisionValue) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setInt('precision', precisionValue);

  return prefs.commit();
}

Future<bool> setDelayValue(int delayValue) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setInt('delay', delayValue);

  return prefs.commit();
}
