import 'package:flutter/material.dart';

class MainProvider extends ChangeNotifier {
  int currentIndex = 0;

  setTab(int i) {
    currentIndex = i;
    notifyListeners();
  }
}
