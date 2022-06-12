import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:prestamos/src/design/designs.dart';
import 'package:prestamos/src/models/stadistics_model.dart';
import 'package:prestamos/src/provider/stadistics_provider.dart';
import 'package:provider/provider.dart';

class QueriesView extends StatelessWidget {
  const QueriesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final stadisticsProvider = Provider.of<StadisticsProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.95),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: DesignText('Estadisticas', fontWeight: FontWeight.bold),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: Builder(builder: (context) {
        if (stadisticsProvider.stadistics != null) {
          return _Graphs(stadisticsProvider.stadistics!);
        } else {
          return Center(child: CupertinoActivityIndicator(radius: 15));
        }
      }),
    );
  }
}

class _Graphs extends StatelessWidget {
  final StadisticsModel stadistics;

  const _Graphs(this.stadistics);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(15),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(15),
            height: 100,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xff4310BE), Color(0xff5E2CD3)],
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
              ),
              boxShadow: [
                BoxShadow(blurRadius: 3, spreadRadius: 3, color: Colors.black.withOpacity(0.05), offset: Offset(0, 5)),
              ],
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Spacer(),
                DesignText('Crecimiento', color: Colors.white54, fontSize: 16),
                SizedBox(height: 5),
                Row(
                  children: [
                    DesignText('${stadistics.crecimiento.toStringAsFixed(2)}x', color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
                    SizedBox(width: 20),
                    Transform.translate(offset: Offset(0, -3), child: Icon(FeatherIcons.arrowUp, color: Colors.white54, size: 40)),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 15),
          Row(
            children: [
              Expanded(child: _WhiteContainer(title: 'Prestado', value: stadistics.prestado)),
              SizedBox(width: 8),
              Expanded(child: _WhiteContainer(title: 'Utilidad', value: stadistics.utilidad)),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(child: _WhiteContainer(title: 'Por cobrar', value: stadistics.faltante)),
              SizedBox(width: 8),
              Expanded(child: _WhiteContainer(title: 'Gastos', value: stadistics.gastos)),
            ],
          ),
          SizedBox(height: 50),
          PieChart(
            dataMap: {
              'Prestado': stadistics.prestado,
              'Utilidad': stadistics.utilidad,
              'Por cobrar': stadistics.faltante,
              'Gastos': stadistics.gastos.abs(),
            },
            animationDuration: Duration(milliseconds: 1200),
            chartLegendSpacing: 32,
            chartRadius: MediaQuery.of(context).size.width / 2.5,
            initialAngleInDegree: 0,
            chartType: ChartType.ring,
            ringStrokeWidth: 32,
            legendOptions: LegendOptions(
              showLegendsInRow: false,
              legendPosition: LegendPosition.right,
              showLegends: true,
              legendTextStyle: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            chartValuesOptions: ChartValuesOptions(
              showChartValueBackground: true,
              showChartValues: true,
              showChartValuesInPercentage: false,
              showChartValuesOutside: false,
              decimalPlaces: 2,
            ),
            // gradientList: ---To add gradient colors---
            // emptyColorGradient: ---Empty Color gradient---
          ),
        ],
      ),
    );
  }
}

class _WhiteContainer extends StatelessWidget {
  final String title;
  final double value;

  const _WhiteContainer({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white, Color(0xffF8FAFB)],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
        boxShadow: [
          BoxShadow(blurRadius: 3, spreadRadius: 3, color: Colors.black.withOpacity(0.05), offset: Offset(0, 5)),
        ],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DesignText(title, color: Colors.black54, fontSize: 13),
          SizedBox(height: 20),
          DesignText('\$${(value).toStringAsFixed(2)}', color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ],
      ),
    );
  }
}
