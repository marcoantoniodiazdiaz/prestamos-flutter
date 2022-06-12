import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:prestamos/src/database/database.dart';
import 'package:prestamos/src/database/preferences.dart';
import 'package:prestamos/src/functions/geolocator_functions.dart';
import 'package:prestamos/src/provider/providers.dart';
import 'package:prestamos/src/utils/loading_utils.dart';
import 'package:prestamos/src/utils/snackbars_utils.dart';

class PaymentsProvider extends ChangeNotifier {
  Future<bool> makePay({required LoansModel loan, required double amount, required double mora}) async {
    try {
      LoadingUtils.showLoading();
      final position = await GeolocatorFunctions.best();
      Get.back();

      Map<String, dynamic> data = {
        'accountId': 1,
        'amount': amount,
        'mora': mora,
        'loanId': loan.id,
        'location': '${position.latitude},${position.longitude}',
        'userId': UserPreferences.id,
      };

      final resp = await PaymentsDatabase.post(data);
      if (resp) {
        final prestamosProvider = Provider.of<PrestamosProvider>(Get.context!, listen: false);
        await prestamosProvider.init();
      }

      return true;
    } catch (e) {
      SnackBarUtils.snackBarError('Valor invalido');
      return false;
    }
  }
}
