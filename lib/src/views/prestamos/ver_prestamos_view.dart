import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:prestamos/src/design/designs.dart';
import 'package:prestamos/src/middlewares/go_page.dart';
import 'package:prestamos/src/models/models.dart';
import 'package:prestamos/src/pipes/image_pipe.dart';
import 'package:prestamos/src/provider/providers.dart';
import 'package:prestamos/src/utils/date_utils.dart';
import 'package:prestamos/src/utils/parsers_utils.dart';
import 'package:prestamos/src/utils/structures.dart';
import 'package:prestamos/src/views/consultas/daily_map_view.dart';
import 'package:prestamos/src/views/prestamos/mapa_view.dart';
import 'package:prestamos/src/views/prestamos/registrar_pago_view.dart';

class VerPrestamosView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final prestamosProvider = Provider.of<PrestamosProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.97),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: DesignText('Todos los prestamos', fontWeight: FontWeight.bold),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(10),
        itemBuilder: (_, i) {
          return _Item(model: prestamosProvider.loans[i]);
        },
        itemCount: prestamosProvider.loans.length,
      ),
    );
  }
}

class _Item extends StatelessWidget {
  final LoansModel model;

  const _Item({required this.model});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(15),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 2, color: Colors.black.withOpacity(0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DesignText('Credito simple', fontSize: 20, fontWeight: FontWeight.bold),
                  SizedBox(height: 2.5),
                  DesignText(DesignUtils.dateShort(model.createdAt), color: Colors.black54),
                  SizedBox(height: 7),
                  DesignText(model.client.name, fontWeight: FontWeight.bold),
                ],
              ),
              CircleAvatar(
                radius: 30,
                backgroundImage: ImagePipes.assetOrNetwork(url: model.client.image),
              ),
            ],
          ),
          Divider(),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DesignText('Prestamo', color: Colors.black54),
                    SizedBox(height: 7),
                    DesignText('\$${model.amount.toStringAsFixed(2)}', fontWeight: FontWeight.bold, fontSize: 20),
                    SizedBox(height: 20),
                    DesignText('A recibir', color: Colors.black54),
                    SizedBox(height: 7),
                    DesignText('\$${model.fee.toStringAsFixed(2)}', fontWeight: FontWeight.bold, fontSize: 20),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DesignText('Pagos individuales de', color: Colors.black54),
                    SizedBox(height: 7),
                    DesignText('\$${model.fee / model.duration}', fontWeight: FontWeight.bold, fontSize: 20),
                    SizedBox(height: 20),
                    DesignText('Periodo', color: Colors.black54),
                    SizedBox(height: 7),
                    DesignText('${model.duration} ${_getPeriod(model.concurrency)}', fontWeight: FontWeight.bold, fontSize: 20),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DesignText('% de pagos', color: Colors.black54),
              DesignText(ParsersUtils.money(StructuresUtils.sum(model.payments.map((e) => e.transaction.amount))), color: Colors.black54),
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
                  width:
                      size.width * 0.82 * ParsersUtils.getPercent(model.amount, StructuresUtils.sum(model.payments.map((e) => e.transaction.amount))),
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
          SizedBox(height: 20),
          Row(
            children: [
              Flexible(
                flex: 10,
                child: DesignTextButton(
                  width: double.infinity,
                  height: 45,
                  child: DesignText('Registrar pago'),
                  color: DesignColors.orange,
                  primary: Colors.white,
                  onPressed: () => GoToMiddleware.goTo(RegistrarPagoView(model: model), 19),
                ),
              ),
              SizedBox(width: 5),
              Flexible(
                flex: 2,
                child: DesignTextButton(
                  width: double.infinity,
                  height: 45,
                  child: Icon(FeatherIcons.calendar),
                  color: DesignColors.dark,
                  primary: Colors.white,
                  onPressed: () {
                    Get.to(() => DailyMapView(loan: model.id));
                  },
                ),
              ),
              SizedBox(width: 5),
              Flexible(
                flex: 2,
                child: DesignTextButton(
                  width: double.infinity,
                  height: 45,
                  child: Icon(FeatherIcons.dollarSign),
                  color: Colors.green,
                  primary: Colors.white,
                  onPressed: () {
                    _showPayments(model.payments);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

_showPayments(List<PaymentsModel> payments) {
  return showCupertinoModalBottomSheet(
    context: Get.context!,
    builder: (_) {
      return Material(
        child: Container(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                DesignText('Historial de pagos', fontWeight: FontWeight.bold),
                ...payments.map((e) {
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    onTap: () => _showPaymentDetails(e),
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
        ),
      );
    },
  );
}

_getPeriod(int concurrency) {
  if (concurrency == 0) return 'dias';
  if (concurrency == 1) return 'semanas';
  if (concurrency == 2) return 'quincenas';
  if (concurrency == 3) return 'meses';
}

_showPaymentDetails(PaymentsModel payment) {
  return showCupertinoModalBottomSheet(
    context: Get.context!,
    builder: (_) {
      return Material(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              DesignText('Detalle de pago', fontWeight: FontWeight.bold),
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
                '\$${payment.transaction.amount.toStringAsFixed(2)}',
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
              SizedBox(height: 10),
              DesignText('Cobrador', fontSize: 12, color: Colors.black54),
              SizedBox(height: 5),
              DesignText(
                payment.user.name,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
              SizedBox(height: 10),
              DesignText('Ubicaci??n', fontSize: 12, color: Colors.black54),
              SizedBox(height: 5),
              DesignTextButton(
                width: 100,
                height: 40,
                child: DesignText('Ver ubicaci??n'),
                color: DesignColors.orange,
                primary: Colors.white,
                onPressed: () => Get.to(() => MapView(model: payment)),
              ),
              // DesignText(
              //   payment.location,
              //   fontWeight: FontWeight.bold,
              //   fontSize: 20,
              // ),
            ],
          ),
        ),
      );
    },
  );
}
