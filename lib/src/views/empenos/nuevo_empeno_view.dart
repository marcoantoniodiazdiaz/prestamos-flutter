import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prestamos/src/design/designs.dart';
import 'package:prestamos/src/pipes/image_pipe.dart';
import 'package:prestamos/src/provider/providers.dart';
import 'package:prestamos/src/utils/date_utils.dart';
import 'package:prestamos/src/utils/parsers_utils.dart';

class NuevoEmpenoView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final clientsProvider = Provider.of<ClientesProvider>(context);
    final empenosProvider = Provider.of<EmpenosProvider>(context);
    final productsProvider = Provider.of<ProductsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: DesignText('Nuevo empeño', fontWeight: FontWeight.bold),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DesignText('Selecciona un usuario para buscar sus prestamos', fontSize: 18, fontStyle: FontStyle.italic),
            Divider(),
            Builder(builder: (_) {
              if (empenosProvider.client == null) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (_, index) {
                    final client = clientsProvider.clients[index];
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: CircleAvatar(backgroundImage: ImagePipes.assetOrNetwork(url: client.image)),
                      title: DesignText(client.name.toUpperCase()),
                      subtitle: DesignText('Pulsa para seleccionar'),
                      onTap: () {
                        empenosProvider.client = client;
                        empenosProvider.getLoansOfClient();
                      },
                    );
                  },
                  itemCount: clientsProvider.clients.length,
                );
              } else {
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(backgroundImage: ImagePipes.assetOrNetwork(url: empenosProvider.client?.image)),
                  title: DesignText(empenosProvider.client!.name.toUpperCase()),
                  trailing: Icon(FeatherIcons.check, color: Colors.green),
                  subtitle: DesignText('Pulsa para deseleccionar'),
                  onTap: () {
                    empenosProvider.client = null;
                  },
                );
              }
            }),
            SizedBox(height: 20),
            DesignText('Selecciona un prestamo', fontSize: 18, fontStyle: FontStyle.italic),
            SizedBox(height: 10),
            Builder(builder: (_) {
              if (empenosProvider.loan == null) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (_, index) {
                    final loan = empenosProvider.loans[index];
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: DesignText('Prestamo de ${ParsersUtils.money(loan.amount)}'),
                      subtitle: DesignText('Creado ${DesignUtils.dateShortWithHour(loan.createdAt)}'),
                      onTap: () => empenosProvider.loan = loan,
                    );
                  },
                  itemCount: empenosProvider.loans.length,
                );
              } else {
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: DesignText('Prestamo de ${ParsersUtils.money(empenosProvider.loan?.amount)}'),
                  subtitle: DesignText('Creado ${DesignUtils.dateShortWithHour(empenosProvider.loan?.createdAt)}'),
                  trailing: Icon(FeatherIcons.check, color: Colors.green),
                  onTap: () => empenosProvider.loan = null,
                );
              }
            }),
            SizedBox(height: 20),
            DesignText('Selecciona un producto', fontSize: 18, fontStyle: FontStyle.italic),
            SizedBox(height: 10),
            Builder(builder: (_) {
              if (empenosProvider.product == null) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (_, index) {
                    final product = productsProvider.available[index];
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: CircleAvatar(backgroundImage: NetworkImage(product.images[0].url), radius: 30),
                      title: DesignText(product.name),
                      subtitle: DesignText(product.description),
                      onTap: () => empenosProvider.product = product,
                    );
                  },
                  itemCount: productsProvider.available.length,
                );
              } else {
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(backgroundImage: NetworkImage(empenosProvider.product!.images[0].url), radius: 30),
                  title: DesignText(empenosProvider.product!.name),
                  subtitle: DesignText('Pulsa para deseleccionar'),
                  trailing: Icon(FeatherIcons.check, color: Colors.green),
                  onTap: () => empenosProvider.product = null,
                );
              }
            }),
            SizedBox(height: 20),
            if (empenosProvider.showButton())
              DesignTextButton(
                width: double.infinity,
                height: 50,
                child: DesignText('Asociar producto al prestamo'),
                color: DesignColors.pink,
                primary: Colors.white,
                onPressed: () => empenosProvider.post(),
              ),
          ],
        ),
      ),
    );
  }
}
