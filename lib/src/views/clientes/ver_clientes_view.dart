import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:prestamos/src/database/database.dart';
import 'package:prestamos/src/design/designs.dart';
import 'package:prestamos/src/pipes/image_pipe.dart';
import 'package:prestamos/src/provider/clientes_provider.dart';
import 'package:prestamos/src/utils/structures.dart';
import 'package:prestamos/src/views/atrasos/atrasos_view.dart';
import 'package:prestamos/src/views/clientes/clientes_vermas_view.dart';
import 'package:prestamos/src/views/clientes/phones_menu_view.dart';
import 'package:provider/provider.dart';

class VerClientesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final clientsProvider = Provider.of<ClientesProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: DesignText('Todos los clientes', fontWeight: FontWeight.bold),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 10),
        physics: BouncingScrollPhysics(),
        itemBuilder: (_, i) {
          return ListTile(
            onTap: () {
              Get.to(() => ClientesVerMasView(model: clientsProvider.clients[i]));
            },
            title: DesignText(clientsProvider.clients[i].name.toUpperCase()),
            subtitle: DesignText('Pulsa para ver opciones'),
            leading: CircleAvatar(
              radius: 23,
              backgroundImage: ImagePipes.assetOrNetwork(url: clientsProvider.clients[i].image),
            ),
            trailing: DesignTextButton(
              width: 65,
              height: 40,
              child: Icon(FeatherIcons.phone),
              color: DesignColors.pink,
              primary: Colors.white,
              onPressed: () => Get.to(() => PhonesView(model: clientsProvider.clients[i])),
            ),
          );
        },
        itemCount: clientsProvider.clients.length,
      ),
    );
  }
}
