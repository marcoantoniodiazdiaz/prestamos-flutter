import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:prestamos/src/database/preferences.dart';
import 'package:prestamos/src/utils/snackbars_utils.dart';

class GoToMiddleware {
  static goTo(Widget page, int code) {
    if (!(UserPreferences.getIntPermissions().toList()).contains(code)) {
      SnackBarUtils.snackBarWarning('Pantalla restringida, asegurate de tener los permisos nesesarios');
      return;
    }

    return Get.to(() => page);
  }
}
