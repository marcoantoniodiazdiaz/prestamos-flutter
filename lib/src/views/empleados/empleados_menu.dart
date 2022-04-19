import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prestamos/src/design/designs.dart';
import 'package:prestamos/src/views/clientes/nuevo_cliente_view.dart';
import 'package:prestamos/src/views/empleados/ver_empleados_view.dart';

class EmpleadosMenuView extends StatelessWidget {
  const EmpleadosMenuView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: DesignColors.dark,
        title: DesignText('Empleados'),
        elevation: 0,
      ),
      body: ListView(
        padding: EdgeInsets.all(15),
        children: [
          _FlatItem(
            onTap: () => Get.to(() => VerEmpleadosView()),
            title: 'Ver empleados',
            subtitle: 'Administra tus empleados registrados',
            icon: FeatherIcons.users,
          ),
          _FlatItem(
            onTap: () => Get.to(() => NuevoClienteView()),
            title: 'Nuevo empleado',
            subtitle: 'Registrar nuevo cliente',
            icon: FeatherIcons.userPlus,
          ),
          _FlatItem(
            onTap: () {
              // _showEmployees();
            },
            title: 'Permisos',
            subtitle: 'Asigna y administra permisos para los empleads',
            icon: FeatherIcons.edit,
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
