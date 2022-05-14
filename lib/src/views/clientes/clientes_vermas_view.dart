import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prestamos/src/database/database.dart';
import 'package:prestamos/src/design/designs.dart';
import 'package:prestamos/src/pipes/image_pipe.dart';
import 'package:prestamos/src/provider/providers.dart';
import 'package:prestamos/src/utils/structures.dart';
import 'package:prestamos/src/views/atrasos/atrasos_view.dart';

class ClientesVerMasView extends StatelessWidget {
  final ClientsModel model;

  const ClientesVerMasView({required this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: DesignText(model.name.toUpperCase(), fontWeight: FontWeight.bold),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DesignText('Prestamos de este cliente', fontSize: 20, fontWeight: FontWeight.bold),
            SizedBox(height: 10),
            _Prestamos(model: model),
          ],
        ),
      ),
    );
  }
}

class _Prestamos extends StatelessWidget {
  final ClientsModel model;

  const _Prestamos({required this.model});
  @override
  Widget build(BuildContext context) {
    final prestamosProvider = Provider.of<PrestamosProvider>(context);
    final prestamos = prestamosProvider.loans.where((e) => e.client.id == model.id).toList();

    return ListView.builder(
      itemBuilder: (_, index) {
        return _LoanItem(loan: prestamos[index]);
      },
      itemCount: prestamos.length,
      shrinkWrap: true,
    );
  }
}

class _LoanItem extends StatelessWidget {
  final LoansModel loan;

  const _LoanItem({required this.loan});

  @override
  Widget build(BuildContext context) {
    final restant = StructuresUtils.sum(loan.payments.map((e) => e.transaction.amount));
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
                backgroundImage: ImagePipes.assetOrNetwork(url: loan.client.image),
              ),
              SizedBox(width: 10),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DesignText(loan.client.name.toUpperCase(), fontSize: 16, fontWeight: FontWeight.bold),
                    SizedBox(height: 5),
                    DesignText('Prestamo por: \$${loan.amount + loan.fee} (${loan.interest}%)', fontSize: 14),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          DesignText('Retraso', fontSize: 13, color: Colors.black54),
          SizedBox(height: 2.5),
          DesignText('10 dias, 8 horas y 10 minutos', fontSize: 14),
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
                    DesignText('\$${loan.fee.toStringAsFixed(2)}', fontSize: 17),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          _Progress(percent: restant / loan.fee),
          SizedBox(height: 7.5),
          Center(
              child: DesignText('${(restant / loan.fee * 100).toStringAsFixed(2)}%',
                  fontSize: 13, color: Colors.black54)),
          SizedBox(height: 10),
          DesignText('Mapa diario', fontSize: 13, color: Colors.black54),
          SizedBox(height: 5),
          FutureBuilder(
            future: getDayList(loan),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return SizedBox(height: 60, child: CupertinoActivityIndicator());
              } else {
                return SizedBox(
                  height: 60,
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    children: snapshot.data,
                    scrollDirection: Axis.horizontal,
                  ),
                );
              }
            },
          ),
          SizedBox(height: 10),
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
