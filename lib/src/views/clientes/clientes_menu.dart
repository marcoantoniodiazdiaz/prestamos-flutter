import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:prestamos/src/design/designs.dart';
import 'package:prestamos/src/views/clientes/nuevo_cliente_view.dart';
import 'package:prestamos/src/views/clientes/ver_clientes_view.dart';

class ClientesMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: DesignText('Clientes', fontWeight: FontWeight.bold),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.all(15),
        children: [
          _FlatItem(
            onTap: () => Get.to(() => VerClientesView()),
            title: 'Ver clientes',
            subtitle: 'Administra tus clientes registrados',
            icon: FeatherIcons.users,
          ),
          _FlatItem(
            onTap: () => Get.to(() => NuevoClienteView()),
            title: 'Nuevo cliente',
            subtitle: 'Registrar nuevo cliente',
            icon: FeatherIcons.userPlus,
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
