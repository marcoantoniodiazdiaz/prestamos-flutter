import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prestamos/src/database/database.dart';
import 'package:prestamos/src/design/designs.dart';
import 'package:prestamos/src/provider/providers.dart';

class AtrasosView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final atrasosProvider = Provider.of<AtrasosProvider>(context);
    final prestamosProvider = Provider.of<PrestamosProvider>(context);
    final atrasos = atrasosProvider.getAtrasos(prestamosProvider.loans).where((e) => e.delayed).toList();
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
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.all(15),
        itemBuilder: (_, index) {
          return _Item(loan: atrasos[index].loan);
        },
        itemCount: atrasos.length,
      ),
      // body: SingleChildScrollView(
      //   padding: EdgeInsets.all(15),
      //   physics: BouncingScrollPhysics(),
      //   child: Column(
      //     children: [
      //       _Item(),
      //     ],
      //   ),
      // ),
    );
  }
}

class _Item extends StatelessWidget {
  final LoansModel loan;

  const _Item({required this.loan});

  @override
  Widget build(BuildContext context) {
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
              CircleAvatar(),
              SizedBox(width: 10),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DesignText(loan.client.name.toUpperCase(), fontSize: 16, fontWeight: FontWeight.bold),
                    SizedBox(height: 5),
                    DesignText('Prestamo por: \$2000.00', fontSize: 14),
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
                    DesignText('\$1300.00', fontSize: 17),
                  ],
                ),
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    DesignText('Cantidad restante', fontSize: 13, color: Colors.black54),
                    SizedBox(height: 2.5),
                    DesignText('\$700.00', fontSize: 17),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          _Progress(),
          SizedBox(height: 7.5),
          Center(child: DesignText('10%', fontSize: 13, color: Colors.black54)),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}

class _Progress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
            width: size.width * 0.82 * 0.8,
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