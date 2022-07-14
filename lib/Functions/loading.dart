import 'package:flutter/material.dart';

class LoadingState extends ChangeNotifier{
 
 bool _isLoading = false;

 bool get isLoading => _isLoading;

  setLoading(bool value) {
   _isLoading = value;
   notifyListeners();
 }
}