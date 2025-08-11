import 'package:flutter/material.dart';

class CreditProvider extends ChangeNotifier {
  int _credits = 10;

  int get credits => _credits;

  bool spendCredit({int amount = 1}) {
    if (_credits >= amount) {
      _credits -= amount;
      notifyListeners();
      return true;
    }
    return false;
  }

  void addCredits(int amount) {
    _credits += amount;
    notifyListeners();
  }
}