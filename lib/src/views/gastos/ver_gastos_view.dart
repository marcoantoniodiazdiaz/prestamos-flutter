import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:prestamos/src/design/texts.dart';
import 'package:prestamos/src/models/expenses_model.dart';
import 'package:prestamos/src/provider/providers.dart';
import 'package:prestamos/src/utils/date_utils.dart';
import 'package:prestamos/src/utils/parsers_utils.dart';

class VerGastosView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final expensesProvider = Provider.of<ExpensesProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: DesignText('Todos los gastos', fontWeight: FontWeight.bold),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 10),
        physics: BouncingScrollPhysics(),
        itemBuilder: (_, index) {
          return ListTile(
            title: DesignText(expensesProvider.expenses[index].name),
            leading: CircleAvatar(radius: 25, backgroundColor: Colors.red, child: Icon(FeatherIcons.arrowDown, color: Colors.white)),
            onTap: () => showCupertinoModalBottomSheet(context: context, builder: (_) => _ShowInformation(model: expensesProvider.expenses[index])),
            subtitle: DesignText('Pulsa para ver más información'),
            trailing: DesignText('-' + ParsersUtils.money(expensesProvider.expenses[index].transaction.amount)),
          );
        },
        itemCount: expensesProvider.expenses.length,
      ),
    );
  }
}

class _ShowInformation extends StatelessWidget {
  final ExpensesModel model;

  const _ShowInformation({required this.model});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            DesignText('Detalle del gasto', fontWeight: FontWeight.bold),
            /*...payments.map((e) {
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
              */
            SizedBox(height: 15),
            DesignText('Cantidad', fontSize: 12, color: Colors.black54),
            SizedBox(height: 5),
            DesignText(
              '\$${model.transaction.amount.toStringAsFixed(2)}',
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
            SizedBox(height: 10),
            DesignText('Descripción', fontSize: 12, color: Colors.black54),
            SizedBox(height: 5),
            DesignText(
              model.description,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
            SizedBox(height: 10),
            DesignText('Usuario', fontSize: 12, color: Colors.black54),
            SizedBox(height: 5),
            DesignText(
              model.user.name,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
            SizedBox(height: 10),
            DesignText('Cuenta', fontSize: 12, color: Colors.black54),
            SizedBox(height: 5),
            DesignText(
              model.transaction.account.name,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
            SizedBox(height: 10),
            DesignText('Fecha/Hora', fontSize: 12, color: Colors.black54),
            SizedBox(height: 5),
            DesignText(
              DesignUtils.dateShortWithHour(model.createdAt),
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ],
        ),
      ),
    );
  }
}
