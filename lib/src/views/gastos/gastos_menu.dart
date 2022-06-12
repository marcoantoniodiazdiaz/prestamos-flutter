import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:prestamos/src/design/designs.dart';
import 'package:prestamos/src/middlewares/go_page.dart';
import 'package:prestamos/src/views/gastos/nuevo_gasto_view.dart';
import 'package:prestamos/src/views/gastos/ver_gastos_view.dart';

class GastosMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: DesignText('Gastos', fontWeight: FontWeight.bold),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: ListView(
        padding: EdgeInsets.all(15),
        children: [
          _FlatItem(
            title: 'Ver gastos',
            subtitle: 'Administra tus gastos registrados',
            icon: FeatherIcons.users,
            onTap: () => GoToMiddleware.goTo(VerGastosView(), 9),
          ),
          _FlatItem(
            title: 'Nuevo gasto',
            subtitle: 'Registrar nuevo gasto',
            icon: FeatherIcons.userPlus,
            onTap: () => GoToMiddleware.goTo(NuevoGastoView(), 10),
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
            CircleAvatar(child: Icon(icon, color: Colors.white), backgroundColor: DesignColors.orange),
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
