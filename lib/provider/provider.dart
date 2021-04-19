import 'package:flutter/material.dart';

class PlayerProvider extends ChangeNotifier {
  int _userID;

  void setID(int data) {
    _userID = data;
    notifyListeners();
  }

  int get userID {
    return _userID;
  }
}
