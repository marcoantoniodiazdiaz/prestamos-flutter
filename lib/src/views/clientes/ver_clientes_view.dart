import 'package:flutter/material.dart';
import 'package:prestamos/src/design/colors_design.dart';
import 'package:prestamos/src/design/texts.dart';
import 'package:prestamos/src/pipes/image_pipe.dart';
import 'package:prestamos/src/provider/clientes_provider.dart';
import 'package:provider/provider.dart';

class VerClientesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final clientsProvider = Provider.of<ClientesProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: DesignColors.dark,
        title: DesignText('Todos los clientes'),
        elevation: 0,
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 10),
        physics: BouncingScrollPhysics(),
        itemBuilder: (_, i) {
          return ListTile(
            onLongPress: () {},
            title: DesignText(clientsProvider.clients[i].name),
            subtitle: DesignText('Pulsa para editar'),
            leading: CircleAvatar(
              radius: 23,
              backgroundImage: ImagePipes.assetOrNetwork(url: clientsProvider.clients[i].image),
            ),
          );
        },
        itemCount: clientsProvider.clients.length,
      ),
    );
  }
}
