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

        final currentLoan = prestamosProvider.loans.firstWhere((e) => e.id == loan.id);

        final paid = StructuresUtils.sum(currentLoan.payments.map((e) => e.transaction.amount));

        final link = WhatsAppUnilink(
          phoneNumber: '+52-3315856646',
          text: """${UserPreferences.name} a recibido tu pago de \$${amount.toStringAsFixed(2)}

*DATOS DE PRESTAMO*
Cantidad prestada: ${currentLoan.amount}
Cantidad a pagar: ${currentLoan.fee}
Cantidad pagada: $paid
Cantidad restante: ${currentLoan.fee - (paid + amount)}

*PAGOS*
${currentLoan.payments.map((e) => "${e.transaction.amount} -> ${DesignUtils.dateShortWithHour(e.createdAt)}").join('\n')}
""",
        );
        // ignore: deprecated_member_use
        await launch('$link');
      }

      return true;
    } catch (e) {
      SnackBarUtils.snackBarError('Valor invalido');
      return false;
    }
  }
}
