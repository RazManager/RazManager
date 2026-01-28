import 'package:flutter/material.dart';

class RefreshModel extends ChangeNotifier {
  void refreshed() {
    notifyListeners();
  }
}
