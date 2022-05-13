import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:prestamos/src/design/designs.dart';
import 'package:prestamos/src/middlewares/go_page.dart';
import 'package:prestamos/src/views/empenos/empeno_menu.dart';
import 'package:prestamos/src/views/prestamos/inventario_view.dart';
import 'package:prestamos/src/views/prestamos/nuevo_prestamo_view.dart';
import 'package:prestamos/src/views/prestamos/ver_prestamos_view.dart';

class PrestamosMenu extends StatelessWidget {
  const PrestamosMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: DesignText('Prestamos', fontWeight: FontWeight.bold),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.all(15),
        children: [
          _FlatItem(
            onTap: () => GoToMiddleware.goTo(VerPrestamosView(), 1),
            title: 'Ver prestamos',
            subtitle: 'Administra y visualiza tus prestamos',
            icon: FeatherIcons.dollarSign,
          ),
          _FlatItem(
            onTap: () {
              Get.to(() => SelectUserForNewLoan());
            },
            title: 'Nuevo prestamo',
            subtitle: 'Registra un nuevo prestamo realizado',
            icon: FeatherIcons.plus,
          ),
          _FlatItem(
            onTap: () {
              showCupertinoModalBottomSheet(
                context: context,
                builder: (context) {
                  return EmpenoMenu();
                },
              );
            },
            title: 'Nuevo empeño',
            subtitle: 'Registra un nuevo empeño realizado',
            icon: FeatherIcons.plusSquare,
          ),
          _FlatItem(
            onTap: () => Get.to(() => InventarioView()),
            title: 'Inventario',
            subtitle: 'Administra y visualiza tus productos',
            icon: FeatherIcons.box,
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
