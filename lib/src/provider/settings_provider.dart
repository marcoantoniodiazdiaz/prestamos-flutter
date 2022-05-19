import 'package:flutter/widgets.dart';
import 'package:prestamos/src/database/settings_database.dart';

class SettingsProvider with ChangeNotifier {
  SettingsProvider() {
    getMora();
  }

  String mora = '0.0';

  getMora() async {
    final resp = await SettingsDatabase.key('mora');
    if (resp == null) return 0.0;

    mora = resp.value;
    notifyListeners();
  }

  updateMora() async {
    final data = {
      'key': 'mora',
      'value': mora,
    };
    await SettingsDatabase.post(data);
    getMora();
  }
}
