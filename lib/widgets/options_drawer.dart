import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/comandos_provider.dart';

class OptionsDrawer extends StatefulWidget {
  @override
  _OptionsDrawerState createState() => _OptionsDrawerState();
}

class _OptionsDrawerState extends State<OptionsDrawer> {
  int _sliderPrecisao = 0;
  int _sliderDelay = 0;

  @override
  Widget build(BuildContext context) {
    final valueProvider = Provider.of<ComandosProvider>(context);
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
                valueProvider.receiveDelayAndPrecisionValues(
                    precision: _sliderPrecisao);
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
            max: 10000.0,
            divisions: 100,
            label: '$_sliderDelay',
            onChanged: (double newValue) {
              setState(() {
                _sliderDelay = newValue.round();
                valueProvider.receiveDelayAndPrecisionValues(
                    delay: _sliderPrecisao);
              });
            },
          ),
        ],
      ),
    );
  }
}
