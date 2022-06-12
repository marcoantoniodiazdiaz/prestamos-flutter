import 'package:flutter/widgets.dart';
import 'package:prestamos/src/database/moras_database.dart';
import 'package:prestamos/src/models/moras_model.dart';

class MorasProvider with ChangeNotifier {
  List<MorasModel> _moras = [];
  List<MorasModel> get moras => _moras;

  MorasProvider() {
    init();
  }

  void init() async {
    _moras = await MorasDatabase.get();
    notifyListeners();
  }
}
