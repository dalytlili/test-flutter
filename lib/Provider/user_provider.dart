import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  String? _userEmail;

  String? get userEmail => _userEmail;

  void setUserEmail(String email) {
    _userEmail = email;
    notifyListeners();
  }

  void clearUserEmail() {
    _userEmail = null;
    notifyListeners();
  }
}
