import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsDrawerProvider with ChangeNotifier {
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
}
