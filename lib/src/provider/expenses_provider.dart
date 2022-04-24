import 'package:flutter/material.dart';
import 'package:prestamos/src/database/clients_database.dart';
import 'package:prestamos/src/database/expenses_database.dart';
import 'package:prestamos/src/database/preferences.dart';
import 'package:prestamos/src/models/expenses_model.dart';

class ExpensesProvider extends ChangeNotifier {
  ExpensesProvider() {
    reload();
  }

  final formKey = GlobalKey<FormState>();

  late String name, description, amount;
  int accountId = -1;

  List<ExpensesModel> _expenses = [];
  List<ExpensesModel> get expenses => _expenses;

  reload() async {
    _expenses = await ExpensesDatabase.get();
    notifyListeners();
  }

  repaint() {
    notifyListeners();
  }

  bool isValidForm(GlobalKey<FormState> key) {
    return key.currentState?.validate() ?? false;
  }

  post() async {
    if (!isValidForm(formKey)) return false;
    if (accountId == -1) return false;

    final Map<String, dynamic> data = {
      'name': name,
      'description': description,
      'userId': UserPreferences.id,
      'amount': amount,
      'accountId': accountId,
    };

    final resp = await ExpensesDatabase.post(data);

    if (resp) {
      reload();
    }

    return resp;
  }
}
