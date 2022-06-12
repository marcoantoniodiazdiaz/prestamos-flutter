import 'package:flutter/widgets.dart';
import 'package:prestamos/src/database/settings_database.dart';
import 'package:prestamos/src/middlewares/regex_exp.dart';
import 'package:prestamos/src/utils/snackbars_utils.dart';

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
    if (double.tryParse(mora) == null) return SnackBarUtils.snackBarWarning('Valor de mora no válido');
    final data = {
      'key': 'mora',
      'value': mora,
    };
    await SettingsDatabase.post(data);
    getMora();
  }
}
