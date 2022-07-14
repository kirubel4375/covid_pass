import 'package:flutter/material.dart';
class PasswordVisibility extends ChangeNotifier{

  bool _watchingPass = false;

  IconData get currentIcon => _watchingPass? Icons.visibility_off: Icons.visibility;

  bool get visible =>_watchingPass;

  void toggleIcon(){
    _watchingPass = !_watchingPass;
    notifyListeners();
  }
}