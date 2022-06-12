import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prestamos/src/database/database.dart';
import 'package:prestamos/src/design/designs.dart';
import 'package:prestamos/src/models/arrears_day_model.dart';
import 'package:prestamos/src/utils/date_utils.dart';

class DailyMapView extends StatelessWidget {
  final int loan;

  const DailyMapView({required this.loan});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.95),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: DesignText('Mapa diario', fontWeight: FontWeight.bold),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: FutureBuilder(
        future: LoansDatabase.getDailyMap(loan),
        builder: (BuildContext context, AsyncSnapshot<List<ArrearDayModel>> snapshot) {
          final now = DateTime.now();
          if (snapshot.hasData) {
            final List<ArrearDayModel> days = snapshot.data!;
            return SingleChildScrollView(
              padding: EdgeInsets.all(15),
              child: Center(
                child: Column(
                  children: [
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      runAlignment: WrapAlignment.center,
                      spacing: 10,
                      runSpacing: 10,
                      children: days.map((e) {
                        return _Day(
                          date: e.date,
                          cutDay: e.cutDay,
                          daily: e.daylyAmount,
                          today: e.date.day == now.day && e.date.month == now.month && e.date.year == now.year,
                          covered: e.covered,
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        CircleAvatar(backgroundColor: DesignColors.blue, radius: 10),
                        SizedBox(width: 10),
                        DesignText('Hoy'),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        CircleAvatar(backgroundColor: DesignColors.pink, radius: 10),
                        SizedBox(width: 10),
                        DesignText('Fecha de pago'),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        CircleAvatar(backgroundColor: DesignColors.orange, radius: 10),
                        SizedBox(width: 10),
                        DesignText('Fecha de pago cubierta'),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        CircleAvatar(backgroundColor: Colors.lightGreen, radius: 10),
                        SizedBox(width: 10),
                        DesignText('Dia cubierto'),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }

          return Center(child: CupertinoActivityIndicator());
        },
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
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: _getDayBackgroundColor(cutDay, today, covered),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DesignText(date.day.toString(), color: cutDay || today || covered ? Colors.white : Colors.black),
          DesignText(DesignUtils.intToMonthShort(date.month), fontSize: 11, color: cutDay || today || covered ? Colors.white : Colors.black),
          SizedBox(height: 2.5),
          DesignText('\$${daily.toStringAsFixed(2)}', color: cutDay || today || covered ? Colors.white : Colors.black),
        ],
      ),
    );
  }
}

Color _getDayBackgroundColor(bool cutDay, bool today, bool covered) {
  if (today) return DesignColors.blue;
  if (covered && cutDay) return DesignColors.orange;
  if (covered) return Colors.lightGreen;
  if (cutDay) return DesignColors.pink;

  return Colors.black.withOpacity(0.08);
}
