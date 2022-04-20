import 'package:flutter/material.dart';
import 'package:prestamos/src/database/accounts_database.dart';
import 'package:prestamos/src/models/accounts_model.dart';

class AccountsProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Form properties
  String name = '';

  AccountsProvider() {
    reload();
  }

  List<AccountsModel> _accounts = [];
  List<AccountsModel> get accounts => _accounts;

  reload() async {
    _accounts = await AccountsDatabase.get();
    notifyListeners();
  }

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }

  Future<bool> add() async {
    if (!isValidForm()) return false;

    Map<String, dynamic> data = {
      'name': name,
    };

    final resp = await AccountsDatabase.post(data);
    if (resp) {
      reload();
    }

    return resp;
  }
}
