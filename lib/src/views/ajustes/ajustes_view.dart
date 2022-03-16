import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prestamos/src/design/colors_design.dart';
import 'package:prestamos/src/design/texts.dart';
import 'package:prestamos/src/views/empleados/permisos_view.dart';

class AjustesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: DesignColors.dark,
        title: DesignText('Ajustes'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            SizedBox(height: 10),
            _FlatItem(
              title: 'Porcentaje de mora',
              subtitle: 'Determina el porcentaje de comisión por pagos tardios',
              icon: FeatherIcons.percent,
              onTap: () {},
            ),
            _FlatItem(
              title: 'Mi información',
              subtitle: 'Determina el porcentaje de comisión por pagos tardios',
              icon: FeatherIcons.info,
              onTap: () {},
            ),
            // _FlatItem(
            //   title: 'Permisos',
            //   subtitle: 'Determina el porcentaje de comisión por pagos tardios',
            //   icon: FeatherIcons.edit,
            //   onTap: () => Get.to(() => PermisosView()),
            // ),
            _FlatItem(
              title: 'Cambiar contraseña',
              subtitle: 'Determina el porcentaje de comisión por pagos tardios',
              icon: FeatherIcons.lock,
              onTap: () {},
            ),
          ],
        ),
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
