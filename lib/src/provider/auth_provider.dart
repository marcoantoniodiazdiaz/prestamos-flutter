import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:prestamos/src/database/auth_database.dart';
import 'package:prestamos/src/database/preferences.dart';
import 'package:prestamos/src/provider/actions_provider.dart';
import 'package:prestamos/src/provider/providers.dart';
import 'package:prestamos/src/views/home_view.dart';

class AuthProvider extends ChangeNotifier {
  late String email, password;
  final formKey = GlobalKey<FormState>();

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }

  login() async {
    if (!isValidForm()) return false;

    final Map<String, dynamic> data = {
      'email': email,
      'password': password,
    };

    final resp = await AuthDatabase.login(data);

    if (resp) {
      final actionsProvider = Provider.of<ActionsProvider>(Get.context!, listen: false);
      actionsProvider.loadPermissionsById(UserPreferences.id);
      Get.to(() => HomeView());
    }

    return resp;
  }
}
