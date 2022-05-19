import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:prestamos/src/database/database.dart';
import 'package:prestamos/src/database/preferences.dart';
import 'package:prestamos/src/functions/geolocator_functions.dart';
import 'package:prestamos/src/provider/providers.dart';
import 'package:prestamos/src/utils/date_utils.dart';
import 'package:prestamos/src/utils/snackbars_utils.dart';
import 'package:prestamos/src/utils/structures.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

class PaymentsProvider extends ChangeNotifier {
  Future<bool> makePay({required LoansModel loan}) async {
    try {
      final amount = loan.fee / loan.duration;

      final position = await GeolocatorFunctions.best();

      Map<String, dynamic> data = {
        'accountId': 1,
        'amount': amount,
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
