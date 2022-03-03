import 'package:flutter/material.dart';

class PrestamosProvider extends ChangeNotifier {
  TextEditingController montoController = TextEditingController();
  TextEditingController interesController = TextEditingController();
  TextEditingController cuotaController = TextEditingController();
  TextEditingController duracionController = TextEditingController();

  double monto = 0.0;
  double interes = 0.0;
  double duracion = 0.0;

  List<PrestamosRowInterface> rows = [];

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
    final now = DateTime.now();
    List<PrestamosRowInterface> list = [];

    final pagosDe = monto / duracion;

    for (var i = 0; i < duracion; i++) {
      final dataRow = PrestamosRowInterface(
        date: DateTime.parse(now.toIso8601String()),
        capital: pagosDe,
        interes: pagosDe * interes,
        cuotas: pagosDe + (pagosDe * interes),
      );

      list.add(dataRow);
      now.add(Duration(days: 7));
    }

    return list;
  }
}

class PrestamosRowInterface {
  final DateTime date;
  final double capital;
  final double interes;
  final double cuotas;

  PrestamosRowInterface({required this.date, required this.capital, required this.interes, required this.cuotas});
}