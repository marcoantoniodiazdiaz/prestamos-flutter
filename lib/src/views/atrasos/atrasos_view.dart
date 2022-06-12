import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prestamos/src/design/designs.dart';
import 'package:prestamos/src/models/arrears_model.dart';
import 'package:prestamos/src/pipes/image_pipe.dart';
import 'package:prestamos/src/provider/arrears_provider.dart';
import 'package:prestamos/src/provider/providers.dart';
import 'package:prestamos/src/utils/structures.dart';

class AtrasosView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final arrearsProvider = Provider.of<ArrearsProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.97),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: DesignText('Atrasos', fontWeight: FontWeight.bold),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(15),
        itemBuilder: (_, index) {
          return _Item(arrearsModel: arrearsProvider.arrears[index]);
        },
        itemCount: arrearsProvider.arrears.length,
      ),
    );
  }
}

class _Item extends StatelessWidget {
  final ArrearsModel arrearsModel;

  const _Item({required this.arrearsModel});

  @override
  Widget build(BuildContext context) {
    final restant = StructuresUtils.sum(arrearsModel.loan.payments.map((e) => e.transaction.amount));
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 2, color: Color(0xffECEFF4)),
      ),
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: ImagePipes.assetOrNetwork(url: arrearsModel.loan.client.image),
              ),
              SizedBox(width: 10),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DesignText(arrearsModel.loan.client.name.toUpperCase(), fontSize: 16, fontWeight: FontWeight.bold),
                    SizedBox(height: 5),
                    DesignText('Prestamo por: \$${arrearsModel.loan.amount + arrearsModel.loan.fee} (${arrearsModel.loan.interest}%)', fontSize: 14),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          // DesignText('Retraso', fontSize: 13, color: Colors.black54),
          // SizedBox(height: 2.5),
          // DesignText(DurationsUtils.dhm(arrearsModel.delay), fontSize: 14),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DesignText('Cantidad abonada', fontSize: 13, color: Colors.black54),
                    SizedBox(height: 2.5),
                    DesignText('\$${restant.toStringAsFixed(2)}', fontSize: 17),
                  ],
                ),
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    DesignText('Cantidad restante', fontSize: 13, color: Colors.black54),
                    SizedBox(height: 2.5),
                    DesignText('\$${arrearsModel.loan.fee.toStringAsFixed(2)}', fontSize: 17),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          _Progress(percent: restant / arrearsModel.loan.fee),
          SizedBox(height: 7.5),
          Center(child: DesignText('${(restant / arrearsModel.loan.fee * 100).toStringAsFixed(2)}%', fontSize: 13, color: Colors.black54)),
        ],
      ),
    );
  }
}

class _Progress extends StatelessWidget {
  final double percent;

  const _Progress({required this.percent});

  @override
  Widget build(BuildContext context) {
    if (percent < 0 || percent > 1) throw 'Value must be between 0 and 1';
    final size = MediaQuery.of(context).size;
    return Center(
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
            width: size.width * 0.82 * percent,
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
    );
  }
}
