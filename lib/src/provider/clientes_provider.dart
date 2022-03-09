import 'dart:io';

import 'package:flutter/material.dart';

class ClientesProvider extends ChangeNotifier {
  late File _profileSelected;
  File get profileSelected => _profileSelected;
  set profileSelected(File i) {
    _profileSelected = i;
    notifyListeners();
  }
}
