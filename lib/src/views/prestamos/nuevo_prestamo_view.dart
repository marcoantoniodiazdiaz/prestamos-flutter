import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:prestamos/src/design/buttons_design.dart';
import 'package:prestamos/src/design/colors_design.dart';
import 'package:prestamos/src/design/input_design.dart';
import 'package:prestamos/src/design/texts.dart';
import 'package:prestamos/src/models/clients_model.dart';
import 'package:prestamos/src/pipes/image_pipe.dart';
import 'package:prestamos/src/provider/prestamos_provider.dart';
import 'package:prestamos/src/utils/date_utils.dart';
import 'package:prestamos/src/utils/parsers_utils.dart';
import 'package:provider/provider.dart';

class NuevoPrestamoView extends StatelessWidget {
  final ClientsModel client;

  NuevoPrestamoView({required this.client});
  final now = DateTime.now().toIso8601String();

  @override
  Widget build(BuildContext context) {
    final prestamosProvider = Provider.of<PrestamosProvider>(context);
    return GestureDetector(
      onTap: (() => FocusScope.of(context).unfocus()),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => prestamosProvider.execute(),
          backgroundColor: DesignColors.green,
          child: Icon(FeatherIcons.check),
        ),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: DesignText('Nuevo prestamo', fontWeight: FontWeight.bold),
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          foregroundColor: Colors.black,
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
                    CircleAvatar(
                      radius: 35,
                      backgroundImage: ImagePipes.assetOrNetwork(url: client.image),
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DesignText(client.name, fontWeight: FontWeight.bold, fontSize: 18),
                        SizedBox(height: 2.5),
                        DesignText('Desde: ${DesignUtils.dateShort(client.createdAt)}', fontStyle: FontStyle.italic),
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
                      ),
                    ),
                    SizedBox(width: 5),
                    Flexible(
                      child: DesignInput(
                        hintText: '% Interes',
                        textInputType: TextInputType.number,
                        controller: prestamosProvider.interesController,
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
                  color: DesignColors.dark,
                  primary: Colors.white,
                  onPressed: () {},
                ),
                SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Tabla extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final prestamosProvider = Provider.of<PrestamosProvider>(context);
    return LayoutBuilder(builder: (context, constraints) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: ConstrainedBox(
          constraints: BoxConstraints(minWidth: constraints.minWidth),
          child: DataTable(
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
                  DataCell(DesignText(ParsersUtils.money(e.capital))),
                  DataCell(DesignText(ParsersUtils.money(e.interes))),
                  DataCell(DesignText(ParsersUtils.money(e.cuotas))),
                ],
              );
            }).toList(),
          ),
        ),
      );
    });
  }
}

showClientsForLoan(List<ClientsModel> clients) {
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
              DesignText('Clientes', fontWeight: FontWeight.bold),
              ...clients.map(
                (e) {
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    leading: CircleAvatar(
                      backgroundImage: ImagePipes.assetOrNetwork(url: e.image),
                    ),
                    title: DesignText(e.name, fontWeight: FontWeight.bold),
                    subtitle: DesignText(DesignUtils.dateShortWithHour(e.createdAt)),
                    onTap: () {
                      Get.to(() => NuevoPrestamoView(client: e));
                    },
                  );
                },
              ),
            ],
          ),
        ),
      );
    },
  );
}
