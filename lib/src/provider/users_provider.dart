import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:prestamos/src/database/users_database.dart';
import 'package:prestamos/src/models/models.dart';

class UsersProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String name = '';
  String email = '';
  String password = '';
  String image = '';
  File? profileSelected;

  UsersProvider() {
    reload();
  }

  List<UsersModel> _users = [];
  List<UsersModel> get users => _users;

  reload() async {
    _users = await UsersDatabase.get();
    notifyListeners();
  }

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }

  add() async {
    final data = {
      'name': name,
      'email': email,
      'passwordx': password,
      'image': image,
    };

    if (!isValidForm()) return;

    final resp = await UsersDatabase.post(data);

    if (resp) reload();
  }
}
