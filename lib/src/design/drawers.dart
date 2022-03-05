import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prestamos/src/design/colors_design.dart';
import 'package:prestamos/src/design/texts.dart';
import 'package:prestamos/src/views/clientes/nuevo_cliente_view.dart';
import 'package:prestamos/src/views/prestamos/nuevo_prestamo_view.dart';

class DrawerDesign extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: DesignColors.dark,
      child: Column(
        children: [
          SizedBox(height: 70),
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: DesignColors.green,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(height: 10),
          DesignText('Marco Antonio Diaz', color: Colors.white, fontSize: 15),
          SizedBox(height: 20),
          _ListTile(
            title: 'Prestamos',
            subtitle: 'Crear, registrar prestamos',
            icon: FeatherIcons.dollarSign,
            onPress: () {
              Get.back();
              Get.to(() => NuevoPrestamoView());
            },
          ),
          _ListTile(
            title: 'Clientes',
            subtitle: 'Crear y ver información de clientes',
            icon: FeatherIcons.user,
            onPress: () {
              Get.back();
              Get.to(() => NuevoClienteView());
            },
          ),
          _ListTile(
            title: 'Cerrar sesión',
            subtitle: 'Cambiar de perfil',
            icon: FeatherIcons.logOut,
            onPress: () {
              Get.back();
              // Get.to(() => NuevoPrestamoView());
            },
          ),
        ],
      ),
    );
  }
}

class _ListTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final void Function() onPress;

  const _ListTile({required this.title, required this.subtitle, required this.icon, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Icon(icon, color: Colors.white),
            SizedBox(width: 20),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DesignText(title, color: Colors.white),
                  SizedBox(height: 5),
                  DesignText(subtitle, color: Colors.white54),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
