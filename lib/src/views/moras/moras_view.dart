import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prestamos/src/design/designs.dart';
import 'package:prestamos/src/pipes/image_pipe.dart';
import 'package:prestamos/src/provider/moras_provider.dart';
import 'package:prestamos/src/provider/providers.dart';

class MorasView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final morasProvider = Provider.of<MorasProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: DesignText('Moras', fontWeight: FontWeight.bold),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: morasProvider.moras.length,
        itemBuilder: (BuildContext context, int index) {
          final mora = morasProvider.moras[index];
          return ListTile(
            title: DesignText('Prestamo de ${mora.loan.fee.toStringAsFixed(2)}'),
            subtitle: DesignText(mora.loan.client.name),
            trailing: DesignText('\$${mora.transaction.amount.toStringAsFixed(2)}'),
            leading: CircleAvatar(
              backgroundColor: Colors.grey,
              radius: 25,
              backgroundImage: ImagePipes.assetOrNetwork(url: mora.loan.client.image),
            ),
          );
        },
      ),
    );
  }
}
