import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:prestamos/src/design/designs.dart';
import 'package:prestamos/src/middlewares/go_page.dart';
import 'package:prestamos/src/views/empleados/nuevo_empleado_view.dart';
import 'package:prestamos/src/views/empleados/ver_empleados_view.dart';

class EmpleadosMenuView extends StatelessWidget {
  const EmpleadosMenuView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: DesignText('Empleados', fontWeight: FontWeight.bold),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: ListView(
        padding: EdgeInsets.all(15),
        children: [
          _FlatItem(
            title: 'Ver empleados',
            subtitle: 'Administra tus empleados registrados',
            icon: FeatherIcons.users,
            onTap: () => GoToMiddleware.goTo(VerEmpleadosView(), 11),
          ),
          _FlatItem(
            title: 'Nuevo empleado',
            subtitle: 'Registrar nuevo cliente',
            icon: FeatherIcons.userPlus,
            onTap: () => GoToMiddleware.goTo(NuevoEmpleadoView(), 12),
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
