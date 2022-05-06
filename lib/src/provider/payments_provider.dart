import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:prestamos/src/database/database.dart';
import 'package:prestamos/src/functions/geolocator_functions.dart';
import 'package:prestamos/src/provider/providers.dart';
import 'package:prestamos/src/utils/snackbars_utils.dart';

class PaymentsProvider extends ChangeNotifier {
  TextEditingController amountField = TextEditingController();

  Future<bool> makePay({required LoansModel loan}) async {
    try {
      double amount = double.parse(amountField.text);

      final position = await GeolocatorFunctions.best();

      Map<String, dynamic> data = {
        'accountId': 1,
        'amount': amount,
        'loanId': loan.id,
        'location': '${position.latitude},${position.longitude}',
        'userId': 1,
      };

      final resp = await PaymentsDatabase.post(data);
      if (resp) {
        final prestamosProvider = Provider.of<PrestamosProvider>(Get.context!, listen: false);
        prestamosProvider.init();
      }

      return true;
    } catch (e) {
      SnackBarUtils.snackBarError('Valor invalido');
      return false;
    }
  }
}
