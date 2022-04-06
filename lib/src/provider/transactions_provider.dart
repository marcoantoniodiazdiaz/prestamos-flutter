import 'package:flutter/widgets.dart';
import 'package:prestamos/src/database/transactions_database.dart';
import 'package:prestamos/src/models/transactions_model.dart';

class TransactionsProvider extends ChangeNotifier {
  TransactionsProvider() {
    init();
  }

  init() async {
    _transactions = await TransactionsDatabase.get();
    notifyListeners();
  }

  List<TransactionsModel> _transactions = [];
  List<TransactionsModel> get transactions => _transactions;
}
