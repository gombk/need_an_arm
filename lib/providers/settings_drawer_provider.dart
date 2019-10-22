import 'package:flutter/material.dart';

class SettingsDrawerProvider with ChangeNotifier {
  int _precisionValue;
  int _delayValue;

  int get precisionValue {
    return _precisionValue;
  }

  int get delayValue {
    return _delayValue;
  }

  void receiveDelayAndPrecisionValues({int precision, int delay}) {
    _precisionValue = precision;
    _delayValue = delay;

    notifyListeners();
  }
}
