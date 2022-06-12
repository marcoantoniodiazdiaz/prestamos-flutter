import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:prestamos/src/database/database.dart';
import 'package:prestamos/src/database/directions_database.dart';
import 'package:prestamos/src/design/designs.dart';
import 'package:prestamos/src/models/directions_model.dart';
import 'package:prestamos/src/pipes/image_pipe.dart';
import 'package:prestamos/src/provider/directions_provider.dart';
import 'package:prestamos/src/provider/providers.dart';
import 'package:prestamos/src/utils/structures.dart';
import 'package:prestamos/src/views/atrasos/atrasos_view.dart';
import 'package:prestamos/src/views/clientes/nuevo_cliente_view.dart';
import 'package:prestamos/src/views/direcciones/map_directions_view.dart';
import 'package:prestamos/src/views/direcciones/nueva_direccion_view.dart';

class ClientesVerMasView extends StatelessWidget {
  final ClientsModel model;

  const ClientesVerMasView({required this.model});

  @override
  Widget build(BuildContext context) {
    final clientesProvider = Provider.of<ClientesProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: DesignText(model.name.toUpperCase(), fontWeight: FontWeight.bold),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        foregroundColor: Colors.black,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(FeatherIcons.edit2),
            onPressed: () => clientesProvider.setEditing(model),
          ),
          SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DesignText('Direcciones', fontSize: 20, fontWeight: FontWeight.bold),
                IconButton(
                  onPressed: () {
                    Get.to(() => NewDirectionView(clientsModel: model));
                  },
                  icon: Icon(FeatherIcons.plus),
                ),
              ],
            ),
            // SizedBox(height: 10),
            _Direcciones(model: model),
            SizedBox(height: 10),
            DesignText('Prestamos de este cliente', fontSize: 20, fontWeight: FontWeight.bold),
            SizedBox(height: 10),
            _Prestamos(model: model),
          ],
        ),
      ),
    );
  }
}

class _Direcciones extends StatelessWidget {
  const _Direcciones({required this.model});

  final ClientsModel model;

  @override
  Widget build(BuildContext context) {
    final directionsProvider = Provider.of<DirectionsProvider>(context);
    return FutureBuilder(
      future: DirectionsDatabase.get(model.id),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          final List<DirectionsModel> directions = snapshot.data;
          return ListView.builder(
            itemCount: directions.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return Dismissible(
                key: UniqueKey(),
                confirmDismiss: (v) {
                  return directionsProvider.delete(directions[index].id);
                },
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: DesignText(directions[index].street),
                  subtitle: DesignText('${directions[index].suburb}, ${directions[index].city}'),
                  trailing: Builder(builder: (context) {
                    if (directions[index].directionsModelDefault) {
                      return Container(
                        padding: EdgeInsets.all(7),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: DesignText('Default', color: Colors.white),
                      );
                    }
                    return SizedBox();
                  }),
                  onTap: () => Get.to(() => MapDirectionsView(model: directions[index])),
                ),
              );
            },
          );
        } else {
          return Center(child: CupertinoActivityIndicator());
        }
      },
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
      physics: NeverScrollableScrollPhysics(),
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
          Center(child: DesignText('${(restant / loan.fee * 100).toStringAsFixed(2)}%', fontSize: 13, color: Colors.black54)),
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
