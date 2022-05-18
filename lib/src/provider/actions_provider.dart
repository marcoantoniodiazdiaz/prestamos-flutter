import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:prestamos/src/database/database.dart';
import 'package:prestamos/src/database/preferences.dart';
import 'package:prestamos/src/utils/loading_utils.dart';

class ActionsProvider with ChangeNotifier {
  ActionsProvider() {
    reload();
  }

  List<PermissionsModel> _actions = [];
  List<PermissionsModel> get actions => _actions;

  loadPermissionsById(int id) async {
    _actions = await PermissionsDatabase.get(id);
    notifyListeners();
  }

  reload() async {
    if (UserPreferences.id != '') {
      final myPermissions = await PermissionsDatabase.get(UserPreferences.id);
      UserPreferences.setPermissions(myPermissions.where((e) => e.has).map((e) => '${e.action.code}').toList());
    }
    notifyListeners();
  }

  changeStatusPermission(UsersModel user, PermissionsModel permission) async {
    await PermissionsDatabase.update({
      'userId': user.id,
      'actionId': permission.action.id,
    });

    loadPermissionsById(user.id);
  }
}
