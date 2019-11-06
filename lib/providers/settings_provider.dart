import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider with ChangeNotifier {
  //////////// [Setters] ////////////
  Future<bool> saveIp(String ip) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('ip', ip);

    return true;
  }

  Future<bool> savePort(String port) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('port', port);

    return true;
  }

  Future<bool> saveSwitchTheme(bool switchTheme) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('switchTheme', switchTheme);

    return true;
  }

  Future<bool> saveSwitchIp(bool switchIp) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('switchIp', switchIp);

    return true;
  }

  Future<bool> saveSwitchPort(bool switchPort) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('switchPort', switchPort);

    return true;
  }

  //////////// [Getters] ////////////

  Future<String> getIp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString('ip');
  }

  Future<String> getPort() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString('port');
  }

  Future<bool> switchTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getBool('switchTheme');
  }

    Future<bool> switchIp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getBool('switchIp');
  }

    Future<bool> switchPort() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getBool('switchPort');
  }
}
