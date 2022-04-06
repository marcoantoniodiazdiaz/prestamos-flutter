import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:prestamos/src/design/colors_design.dart';
import 'package:prestamos/src/design/texts.dart';
import 'package:prestamos/src/provider/clientes_provider.dart';
import 'package:prestamos/src/views/clientes/nuevo_cliente_view.dart';
import 'package:prestamos/src/views/clientes/ver_clientes_view.dart';
import 'package:prestamos/src/views/prestamos/nuevo_prestamo_view.dart';
import 'package:prestamos/src/views/prestamos/ver_prestamos_view.dart';
import 'package:provider/provider.dart';

class PrestamosMenu extends StatelessWidget {
  const PrestamosMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final clientsProvider = Provider.of<ClientesProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: DesignText('Prestamos', fontWeight: FontWeight.bold),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: ListView(
        padding: EdgeInsets.all(15),
        children: [
          _FlatItem(
            onTap: () => Get.to(() => VerPrestamosView()),
            title: 'Ver prestamos',
            subtitle: 'Administra y visualiza tus prestamos',
            icon: FeatherIcons.dollarSign,
          ),
          _FlatItem(
            onTap: () {
              showClientsForLoan(clientsProvider.clients);
            },
            title: 'Nuevo prestamo',
            subtitle: 'Registra un nuevo prestamo realizado',
            icon: FeatherIcons.plus,
          ),
        ],
      ),
    );
  }
}

class _FlatItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final void Function()? onTap;
  final IconData icon;

  const _FlatItem({
    required this.title,
    required this.subtitle,
    required this.onTap,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Icon(icon),
            SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DesignText(title, fontWeight: FontWeight.bold),
                  SizedBox(height: 2.5),
                  DesignText(subtitle, fontSize: 13, color: Colors.black54),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
