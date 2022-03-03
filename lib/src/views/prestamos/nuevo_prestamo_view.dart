import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prestamos/src/design/buttons_design.dart';
import 'package:prestamos/src/design/colors_design.dart';
import 'package:prestamos/src/design/input_design.dart';
import 'package:prestamos/src/design/texts.dart';
import 'package:prestamos/src/provider/prestamos_provider.dart';
import 'package:prestamos/src/utils/date_utils.dart';
import 'package:provider/provider.dart';

class NuevoPrestamoView extends StatelessWidget {
  final now = DateTime.now().toIso8601String();

  @override
  Widget build(BuildContext context) {
    final prestamosProvider = Provider.of<PrestamosProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: DesignColors.pink,
        title: DesignText('Nuevo prestamo'),
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 75,
                    height: 75,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: DesignColors.pink.withOpacity(0.5),
                    ),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DesignText('Marco Antonio Diaz Diaz', fontWeight: FontWeight.bold, fontSize: 18),
                      SizedBox(height: 2.5),
                      DesignText('Desde: $now', fontStyle: FontStyle.italic),
                    ],
                  )
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Flexible(
                    child: DropdownButton<String>(
                      items: const [
                        DropdownMenuItem(child: DesignText('Quincenal'), value: 'Quincenal'),
                        DropdownMenuItem(child: DesignText('Semanal'), value: 'Semanal'),
                      ],
                      onChanged: (v) {},
                      isExpanded: true,
                      value: 'Quincenal',
                    ),
                  ),
                  SizedBox(width: 5),
                  Flexible(
                    child: DesignInput(
                      hintText: 'Duración',
                      textInputType: TextInputType.numberWithOptions(decimal: false, signed: false),
                      controller: prestamosProvider.duracionController,
                      onFieldSubmitted: (v) => prestamosProvider.execute(),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Flexible(
                    child: DesignInput(
                      hintText: 'Monto',
                      textInputType: TextInputType.numberWithOptions(decimal: false, signed: false),
                      controller: prestamosProvider.montoController,
                      onFieldSubmitted: (v) => prestamosProvider.execute(),
                    ),
                  ),
                  SizedBox(width: 5),
                  Flexible(
                    child: DesignInput(
                      hintText: '% Interes',
                      textInputType: TextInputType.numberWithOptions(decimal: true, signed: false),
                      controller: prestamosProvider.interesController,
                      onFieldSubmitted: (v) => prestamosProvider.execute(),
                    ),
                  ),
                  SizedBox(width: 5),
                  Flexible(
                    child: DesignInput(
                      hintText: 'Cuota',
                      textInputType: TextInputType.numberWithOptions(decimal: false, signed: false),
                      controller: prestamosProvider.cuotaController,
                      enabled: false,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              _Tabla(),
              SizedBox(height: 10),
              DesignTextButton(
                width: double.infinity,
                height: 50,
                child: DesignText('Guardar'),
                color: DesignColors.pink,
                primary: Colors.white,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Tabla extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final prestamosProvider = Provider.of<PrestamosProvider>(context);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columnSpacing: size.width * 0.09,
        columns: [
          DataColumn(label: Text("Fecha")),
          DataColumn(label: Text("Capital"), numeric: true),
          DataColumn(label: Text("Interes"), numeric: true),
          DataColumn(label: Text("Cuota"), numeric: true),
        ],
        rows: prestamosProvider.rows.map((e) {
          return DataRow(
            selected: true,
            cells: [
              DataCell(DesignText(DesignUtils.dateShort(e.date))),
              DataCell(DesignText(e.capital.toStringAsFixed(2))),
              DataCell(DesignText(e.interes.toStringAsFixed(2))),
              DataCell(DesignText(e.cuotas.toStringAsFixed(2))),
            ],
          );
        }).toList(),
      ),
    );
  }
}
