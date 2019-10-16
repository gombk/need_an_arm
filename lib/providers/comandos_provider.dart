import 'package:flutter/foundation.dart';

class ComandosProvider with ChangeNotifier {
  List<String> fileToSend;

  void addStringToList(String msg, int total) {
    for (var i = 0; i < total; i++) {
      fileToSend.add(msg);
    }
  }
}
