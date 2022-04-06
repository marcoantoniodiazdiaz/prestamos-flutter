import 'package:flutter/material.dart';
import 'package:prestamos/src/database/loans_database.dart';
import 'package:prestamos/src/models/loans_model.dart';

class PrestamosProvider extends ChangeNotifier {
  PrestamosProvider() {
    init();
  }

  TextEditingController montoController = TextEditingController();
  TextEditingController interesController = TextEditingController();
  TextEditingController cuotaController = TextEditingController();
  TextEditingController duracionController = TextEditingController();

  List<LoansModel> _loans = [];
  List<LoansModel> get loans => _loans;

  double monto = 0.0;
  double interes = 0.0;
  double duracion = 0.0;

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

      final cuota = monto + (monto * interes);
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
        interes: pagosDe * interes,
        cuotas: pagosDe + (pagosDe * interes),
      );

      list.add(dataRow);
      now = now.add(Duration(days: 7));
    }

    return list;
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
