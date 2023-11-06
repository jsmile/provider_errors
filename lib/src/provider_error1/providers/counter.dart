import 'package:flutter/foundation.dart';

class Counter with ChangeNotifier {
  int counter = 0;

  // int get value => counter;

  void increment() {
    counter++;
    notifyListeners();
  }
}
