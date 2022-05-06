import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prestamos/src/database/database.dart';
import 'package:prestamos/src/design/designs.dart';
import 'package:prestamos/src/pipes/image_pipe.dart';
import 'package:prestamos/src/provider/providers.dart';
import 'package:prestamos/src/utils/structures.dart';

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
          Center(child: DesignText('${(restant / loan.fee * 100).toStringAsFixed(2)}%', fontSize: 13, color: Colors.black54)),
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

class _Day extends StatelessWidget {
  final DateTime date;
  final bool cutDay;
  final double daily;
  final bool today;
  final bool covered;

  const _Day({required this.date, required this.cutDay, required this.daily, required this.today, required this.covered});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 5),
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: _getDayBackgroundColor(cutDay, today, covered),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DesignText(date.day.toString(), color: cutDay || today || covered ? Colors.white : Colors.black),
          DesignText('ABRIL', fontSize: 11, color: cutDay || today || covered ? Colors.white : Colors.black),
          SizedBox(height: 2.5),
          DesignText('\$${daily.toStringAsFixed(2)}', color: cutDay || today || covered ? Colors.white : Colors.black),
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

Future<List<_Day>> getDayList(LoansModel loan) async {
  var start = loan.createdAt;
  final daysToAdd = (loan.duration * 7) + 1; // Añadir 7 por x semanas
  final end = start.add(Duration(days: daysToAdd));

  List<DateTime> cutDays = [];

  var date = start;
  for (var i = 0; i < loan.duration; i++) {
    date = date.add(Duration(days: 7 * (i + 1)));
    cutDays.add(DateTime(date.year, date.month, date.day));
    date = start;
  }

  List<_Day> list = [];

  var paid = StructuresUtils.sum(loan.payments.map((e) => e.transaction.amount));
  bool continueCovered = true;

  final diff = end.difference(start).inDays.abs();
  for (var i = 0; i < diff; i++) {
    bool today = false;
    final dateToAdd = DateTime(start.year, start.month, start.day);

    if (_compareDates(dateToAdd, DateTime.now())) today = true;
    if (paid <= 0) continueCovered = false;

    list.add(
      _Day(
        date: dateToAdd,
        cutDay: _containsDate(dateToAdd, cutDays),
        daily: loan.fee / diff,
        today: today,
        covered: continueCovered,
      ),
    );

    today = false;
    paid -= loan.fee / diff;
    start = start.add(Duration(days: 1));
  }

  return list;
}

bool _containsDate(DateTime first, List<DateTime> list) {
  // return first.day == second.day && first.month == second.month && first.year == second.year;
  for (final date in list) {
    if (_compareDates(first, date)) {
      return true;
    }
  }

  return false;
}

bool _compareDates(DateTime first, DateTime second) {
  return first.day == second.day && first.month == second.month && first.year == second.year;
}

Color _getDayBackgroundColor(bool cutDay, bool today, bool covered) {
  if (cutDay || today || covered) {
    if (cutDay) {
      return DesignColors.pink;
    } else if (today) {
      return DesignColors.blue;
    }

    return Colors.lightGreen;
  }

  return Colors.black.withOpacity(0.08);
}
