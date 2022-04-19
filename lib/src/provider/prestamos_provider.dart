import 'package:flutter/material.dart';
import 'package:prestamos/src/database/database.dart';
import 'package:prestamos/src/models/models.dart';
import 'package:prestamos/src/utils/snackbars_utils.dart';

class PrestamosProvider extends ChangeNotifier {
  PrestamosProvider() {
    init();
  }

  TextEditingController montoController = TextEditingController();
  TextEditingController interesController = TextEditingController();
  TextEditingController cuotaController = TextEditingController();
  TextEditingController duracionController = TextEditingController();

  int _concurrency = 0;
  int get concurrency => _concurrency;
  set concurrency(int i) {
    _concurrency = i;
    notifyListeners();
  }

  List<LoansModel> _loans = [];
  List<LoansModel> get loans => _loans;

  double monto = 0.0;
  double interes = 0.0;
  double duracion = 0.0;
  double cuota = 0.0;

  List<PrestamosRowInterface> rows = [];

  init() async {
    _loans = await LoansDatabase.get();
    notifyListeners();
  }

  execute() {
    try {
      monto = double.parse(montoController.text);
      interes = double.parse(interesController.text);
      duracion = double.parse(duracionController.text);

      cuota = monto + (monto * (interes / 100));
      cuotaController.text = cuota.toString();

      rows = generateRows();
      notifyListeners();
    } catch (e) {
      return;
    }
  }

  List<PrestamosRowInterface> generateRows() {
    DateTime now = DateTime.now();
    List<PrestamosRowInterface> list = [];

    final pagosDe = monto / duracion;

    now = now.add(Duration(days: 7));
    for (var i = 0; i < duracion; i++) {
      final newDate = DateTime(now.year, now.month, now.day);

      final dataRow = PrestamosRowInterface(
        date: newDate,
        capital: pagosDe,
        interes: pagosDe * (interes / 100),
        cuotas: pagosDe + (pagosDe * (interes / 100)),
      );

      list.add(dataRow);
      now = now.add(Duration(days: 7));
    }

    return list;
  }

  createLoan(int clientId) async {
    final Map<String, dynamic> data = {
      'concurrency': _concurrency,
      'amount': monto,
      'duration': duracion,
      'fee': cuota,
      'interest': interes,
      'clientId': clientId,
    };

    await LoansDatabase.post(data);
  }
}

class PrestamosRowInterface {
  final DateTime date;
  final double capital;
  final double interes;
  final double cuotas;

  PrestamosRowInterface({
    required this.date,
    required this.capital,
    required this.interes,
    required this.cuotas,
  });
}
