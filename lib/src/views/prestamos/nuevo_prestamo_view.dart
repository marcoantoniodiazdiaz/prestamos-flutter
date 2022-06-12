import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:prestamos/src/design/designs.dart';
import 'package:prestamos/src/models/models.dart';
import 'package:prestamos/src/pipes/image_pipe.dart';
import 'package:prestamos/src/provider/providers.dart';
import 'package:prestamos/src/utils/date_utils.dart';
import 'package:prestamos/src/utils/parsers_utils.dart';

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
          onPressed: () => prestamosProvider.loadPreview(),
          backgroundColor: DesignColors.orange,
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
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DesignText(client.name, fontWeight: FontWeight.bold, fontSize: 18),
                          SizedBox(height: 2.5),
                          DesignText('Desde: ${DesignUtils.dateShort(client.createdAt)}', fontStyle: FontStyle.italic),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: DesignColors.dark.withOpacity(0.06),
                  ),
                  child: DropdownButton<int>(
                    items: const [
                      DropdownMenuItem(child: DesignText('Diario'), value: 0),
                      DropdownMenuItem(child: DesignText('Semanalmente'), value: 1),
                      DropdownMenuItem(child: DesignText('Quincenal'), value: 2),
                      DropdownMenuItem(child: DesignText('Mensual'), value: 3),
                    ],
                    underline: SizedBox(),
                    onChanged: (int? v) {
                      prestamosProvider.concurrency = v!;
                    },
                    isExpanded: true,
                    value: prestamosProvider.concurrency,
                  ),
                ),
                SizedBox(height: 10),
                DesignInput(
                  hintText: 'Duración',
                  textInputType: TextInputType.numberWithOptions(decimal: false, signed: false),
                  onChanged: (v) => prestamosProvider.duracion = v,
                ),
                SizedBox(height: 10),
                DesignInput(
                  hintText: 'Monto',
                  textInputType: TextInputType.numberWithOptions(decimal: false, signed: false),
                  onChanged: (v) => prestamosProvider.monto = v,
                ),
                SizedBox(height: 10),
                DesignInput(
                  hintText: '% Interes',
                  textInputType: TextInputType.number,
                  onChanged: (v) => prestamosProvider.interes = v,
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    DesignText('Mostrar solo dias de pago'),
                    Switch.adaptive(
                      value: prestamosProvider.showOnlyDayPays,
                      onChanged: (v) {
                        prestamosProvider.changeShowOnlyDayPays(v);
                      },
                    ),
                  ],
                ),
                SizedBox(height: 10),
                _Tabla(),
                SizedBox(height: 10),
                if (prestamosProvider.days != -1)
                  DesignTextButton(
                    width: double.infinity,
                    height: 50,
                    child: DesignText('Guardar prestamo'),
                    color: DesignColors.dark,
                    primary: Colors.white,
                    onPressed: () {
                      prestamosProvider.createLoan(client.id);
                    },
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
                selected: false,
                color: e.payDay ? MaterialStateProperty.all(Colors.green.withOpacity(0.3)) : MaterialStateProperty.all(Colors.transparent),
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

class SelectUserForNewLoan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final clientsProvider = Provider.of<ClientesProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: DesignText('Selecciona el cliente', fontWeight: FontWeight.bold),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            DesignInput(
              hintText: 'Buscar',
              textInputType: TextInputType.text,
              textCapitalization: TextCapitalization.words,
              icon: Icon(FeatherIcons.search),
              onChanged: (String v) {
                clientsProvider.findClient(v);
              },
            ),
            ...clientsProvider.filtered.map(
              (e) {
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                  leading: CircleAvatar(
                    backgroundImage: ImagePipes.assetOrNetwork(url: e.image),
                  ),
                  title: DesignText(e.name.toUpperCase(), fontWeight: FontWeight.bold),
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
  }
}
