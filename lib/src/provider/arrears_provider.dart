import 'package:flutter/widgets.dart';
import 'package:prestamos/src/database/database.dart';
import 'package:prestamos/src/models/arrears_model.dart';

class ArrearsProvider with ChangeNotifier {
  ArrearsProvider() {
    reload();
  }

  List<ArrearsModel> _arrears = [];
  List<ArrearsModel> get arrears => _arrears;

  reload() async {
    _arrears = await LoansDatabase.arrears();
    notifyListeners();
  }
}
