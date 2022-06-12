import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prestamos/src/database/database.dart';
import 'package:prestamos/src/design/designs.dart';
import 'package:prestamos/src/models/amount_pay_model.dart';
import 'package:prestamos/src/models/loans_model.dart';
import 'package:prestamos/src/provider/payments_provider.dart';
import 'package:prestamos/src/provider/providers.dart';
import 'package:prestamos/src/utils/date_utils.dart';
import 'package:prestamos/src/utils/parsers_utils.dart';
import 'package:prestamos/src/utils/structures.dart';

class RegistrarPagoView extends StatelessWidget {
  final LoansModel model;

  const RegistrarPagoView({required this.model});

  @override
  Widget build(BuildContext context) {
    final paymentsProvider = Provider.of<PaymentsProvider>(context);
    final loansProvider = Provider.of<PrestamosProvider>(context);
    final payments = loansProvider.loans.firstWhere((e) => e.id == model.id).payments;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: DesignText('Registrar pago', fontWeight: FontWeight.bold),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Information(model: model),
            SizedBox(height: 10),
            FutureBuilder(
              future: PaymentsDatabase.amountToPay(model.id),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CupertinoActivityIndicator());
                } else {
                  final AmountToPayModel amountToPay = snapshot.data;
                  return DesignTextButton(
                    width: double.infinity,
                    height: 110,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DesignText('Mora definida: \$${(amountToPay.mora).toStringAsFixed(2)}'),
                        SizedBox(height: 5),
                        DesignText('Retraso de: ${(amountToPay.delay)} dias'),
                        SizedBox(height: 5),
                        DesignText('Pago: \$${(amountToPay.organico).toStringAsFixed(2)}'),
                        SizedBox(height: 5),
                        DesignText('Registrar pago de: \$${(amountToPay.total).toStringAsFixed(2)}', fontWeight: FontWeight.bold),
                      ],
                    ),
                    color: Color(0xff1400FF),
                    primary: Colors.white,
                    onPressed: () async {
                      await paymentsProvider.makePay(loan: model, amount: amountToPay.organico, mora: amountToPay.moraAplicada);
                    },
                  );
                }
              },
            ),
            SizedBox(height: 30),
            DesignText('Historial de pagos', fontSize: 20, fontWeight: FontWeight.bold),
            ...payments.map((e) {
              return ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(
                  backgroundColor: Colors.green,
                  child: Icon(FeatherIcons.dollarSign, color: Colors.white),
                ),
                title: DesignText('\$${e.transaction.amount.toStringAsFixed(2)}', fontWeight: FontWeight.bold),
                subtitle: DesignText(DesignUtils.dateShortWithHour(e.createdAt)),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class _Information extends StatelessWidget {
  const _Information({required this.model});

  final LoansModel model;

  @override
  Widget build(BuildContext context) {
    final paid = StructuresUtils.sum(model.payments.map((e) => e.transaction.amount));
    final size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(15),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 2, color: Color(0xffECEFF4)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DesignText('Cantidad', color: Colors.black54),
                  SizedBox(height: 7),
                  DesignText('\$${model.fee.toStringAsFixed(2)}', fontWeight: FontWeight.bold, fontSize: 20),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  DesignText('Restante', color: Colors.black54),
                  SizedBox(height: 7),
                  DesignText(
                    '\$${model.fee - paid}',
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DesignText('% de pagos', color: Colors.black54),
              DesignText('\$$paid', color: Colors.black54),
            ],
          ),
          SizedBox(height: 10),
          Center(
            child: Stack(
              children: [
                Container(
                  width: size.width * 0.82,
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Container(
                  width: size.width *
                      0.82 *
                      ParsersUtils.getPercent(
                        model.amount,
                        StructuresUtils.sum(
                          model.payments.map((e) => e.transaction.amount),
                        ),
                      ),
                  height: 8,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xff0DD1BA), Color(0xff8CEB77)],
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
