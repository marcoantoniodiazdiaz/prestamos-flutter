import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:prestamos/src/design/designs.dart';
import 'package:prestamos/src/views/cuentas/nueva_cuenta_view.dart';
import 'package:prestamos/src/views/cuentas/ver_cuentas_view.dart';

class CuentasView extends StatelessWidget {
  const CuentasView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: DesignText('Cuentas', fontWeight: FontWeight.bold),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: ListView(
        padding: EdgeInsets.all(15),
        physics: BouncingScrollPhysics(),
        children: [
          _FlatItem(
            onTap: () => Get.to(() => VerCuentasView()),
            title: 'Ver cuentas',
            subtitle: 'Administra tus cuentas registrados',
            icon: FeatherIcons.eye,
          ),
          _FlatItem(
            onTap: () => Get.to(() => NuevaCuentaView()),
            title: 'Nueva cuenta',
            subtitle: 'Registrar una nueva cuenta',
            icon: FeatherIcons.plusCircle,
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

// _showEmployees() async {
//   showCupertinoModalBottomSheet(
//     context: Get.context!,
//     builder: (context) {
//       return Material(
//         child: ListView.builder(itemBuilder: (_, i) {
//           return ListTile();
//         }),
//       );
//     },
//   );
// }
