import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:prestamos/src/database/preferences.dart';
import 'package:prestamos/src/utils/snackbars_utils.dart';

class GoToMiddleware {
  static goTo(Widget page, int code) {
    final permissions = UserPreferences.getIntPermissions().toList();
    if (!permissions.contains(code)) {
      SnackBarUtils.snackBarWarning('Pantalla restringida, asegurate de tener los permisos nesesarios. [code: $code]');
      return;
    }

    return Get.to(() => page);
  }

  static bool next(int code) {
    final permissions = UserPreferences.getIntPermissions().toList();
    if (!permissions.contains(code)) {
      SnackBarUtils.snackBarWarning('Pantalla restringida, asegurate de tener los permisos nesesarios. [code: $code]');
      return false;
    }

    return true;
  }
}
