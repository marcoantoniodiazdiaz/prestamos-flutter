import 'package:flutter/widgets.dart';
import 'package:prestamos/src/database/database.dart';
import 'package:prestamos/src/utils/structures.dart';

class AtrasosProvider with ChangeNotifier {
  List<AtrasosModel> getAtrasos(List<LoansModel> loans) {
    List<AtrasosModel> list = [];

    for (final loan in loans) {
      final paid = StructuresUtils.sum(loan.payments.map((e) => e.transaction.amount));
      final duration = loan.duration;

      final firstPaymentAt = loan.createdAt.add(Duration(days: 7));
      final endPayment = firstPaymentAt.add(Duration(days: 7 * duration));
      // Dias transcurridos desde el primer pago hasta el final del tiempo
      final weeksPassed = (DateTime.now().difference(endPayment).inDays / 7).abs();

      if (paid < weeksPassed * loan.fee) {
        // La persona esta retrasada con su pago
        list.add(AtrasosModel(loan, true, paid));
      } else {
        list.add(AtrasosModel(loan, false, paid));
      }
    }

    return list;
  }
}

class AtrasosModel {
  final LoansModel loan;
  final bool delayed;
  final double paid;
  AtrasosModel(this.loan, this.delayed, this.paid);
}
