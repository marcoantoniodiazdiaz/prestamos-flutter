import 'package:flutter/widgets.dart';
import 'package:prestamos/src/database/stadistics_database.dart';
import 'package:prestamos/src/models/stadistics_model.dart';

class StadisticsProvider with ChangeNotifier {
  StadisticsProvider() {
    reload();
  }

  StadisticsModel? _stadistics;
  StadisticsModel? get stadistics => _stadistics;

  reload() async {
    _stadistics = await StadisticsDatabase.get();
    notifyListeners();
  }
}
