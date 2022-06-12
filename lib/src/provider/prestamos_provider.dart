import 'package:flutter/material.dart';
import 'package:prestamos/src/database/database.dart';

class PrestamosProvider extends ChangeNotifier {
  bool showOnlyDayPays = false;

  PrestamosProvider() {
    init();
  }

  int _concurrency = 0;
  int get concurrency => _concurrency;
  set concurrency(int i) {
    _concurrency = i;
    notifyListeners();
  }

  int _days = -1;
  int get days => _days;

  List<LoansModel> _loans = [];
  List<LoansModel> get loans => _loans;

  late String monto, interes, duracion;

  List<PrestamosRowInterface> rows = [];
  List<PrestamosRowInterface> _saveState = [];

  init() async {
    _loans = await LoansDatabase.get();
    notifyListeners();
  }

  changeShowOnlyDayPays(bool i) {
    if (i) {
      _saveState = rows;
      rows = rows.where((e) => e.payDay).toList();
      showOnlyDayPays = true;
    } else {
      rows = _saveState;
      showOnlyDayPays = false;
    }
    notifyListeners();
  }

  loadPreview() async {
    final data = {
      'concurrency': _concurrency,
      'amount': double.parse(monto),
      'duration': int.parse(duracion),
      'interest': double.parse(interes),
    };
    final resp = await LoansDatabase.getPreview(data);

    final m = double.parse(monto);
    final i = double.parse(interes);

    final fee = m + m * (i / 100);

    if (resp != null) {
      _days = resp.days;
      final items = resp.items;
      final dataRows = items.map((e) {
        return PrestamosRowInterface(
          date: e.datetime,
          capital: !showOnlyDayPays ? m / resp.days : 0,
          interes: !showOnlyDayPays ? (m / resp.days) * (i / 100) : 0,
          cuotas: !showOnlyDayPays ? (m / resp.days) + (m / resp.days) * (i / 100) : 0,
          payDay: e.isPayDay,
        );
      }).toList();
      rows = dataRows;
      notifyListeners();
    }
  }

  createLoan(int clientId) async {
    final m = double.parse(monto);
    final i = double.parse(interes);

    final Map<String, dynamic> data = {
      'concurrency': _concurrency,
      'amount': monto,
      'duration': duracion,
      'fee': m + (m * (i / 100)),
      'days': _days,
      'interest': interes,
      'clientId': clientId,
    };

    final resp = await LoansDatabase.post(data);
    if (resp) {
      _days = -1;
      init();
    }
  }
}

class PrestamosRowInterface {
  final DateTime date;
  final double capital;
  final double interes;
  final double cuotas;
  final bool payDay;

  PrestamosRowInterface({
    required this.date,
    required this.capital,
    required this.interes,
    required this.cuotas,
    required this.payDay,
  });
}
