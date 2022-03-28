import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prestamos/src/design/colors_design.dart';
import 'package:prestamos/src/design/texts.dart';
import 'package:prestamos/src/views/ajustes/ajustes_view.dart';
import 'package:prestamos/src/views/clientes/clientes_menu.dart';
import 'package:prestamos/src/views/clientes/nuevo_cliente_view.dart';
import 'package:prestamos/src/views/cuentas/cuentas_view.dart';
import 'package:prestamos/src/views/empleados/empleados_menu.dart';
import 'package:prestamos/src/views/prestamos/nuevo_prestamo_view.dart';
import 'package:prestamos/src/widgets/misc_widgets.dart';

class DrawerDesign extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: DesignColors.dark,
      child: Column(
        children: [
          SizedBox(height: 70),
          MiscWidgets.avatarWithLetter('M', 40, DesignColors.green),
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
              // Get.to(() => NuevoClienteView());
              Get.to(() => ClientesMenu());
            },
          ),
          _ListTile(
            title: 'Consultas',
            subtitle: 'Mostrar información filtrada por campos',
            icon: FeatherIcons.sliders,
            onPress: () {
              Get.back();
              Get.to(() => NuevoClienteView());
            },
          ),
          _ListTile(
            title: 'Cuentas',
            subtitle: 'Crear y ver cuentas generadas',
            icon: FeatherIcons.inbox,
            onPress: () {
              Get.back();
              Get.to(() => CuentasView());
            },
          ),
          _ListTile(
            title: 'Atrasos',
            subtitle: 'Revisar pagos tardios y retrasados',
            icon: FeatherIcons.skipBack,
            onPress: () {
              Get.back();
              Get.to(() => NuevoClienteView());
            },
          ),
          _ListTile(
            title: 'Cartera',
            subtitle: 'Mostrar todas las entradas/salidas de dinero',
            icon: FeatherIcons.creditCard,
            onPress: () {
              Get.back();
              Get.to(() => NuevoClienteView());
            },
          ),
          _ListTile(
            title: 'Gastos',
            subtitle: 'Mostrar gastos realizados',
            icon: FeatherIcons.arrowDown,
            onPress: () {
              Get.back();
              Get.to(() => NuevoClienteView());
            },
          ),
          _ListTile(
            title: 'Empleados',
            subtitle: 'Crear y ver información de empleados',
            icon: FeatherIcons.users,
            onPress: () {
              Get.back();
              Get.to(() => EmpleadosMenuView());
            },
          ),
          _ListTile(
            title: 'Ajustes',
            subtitle: 'Edita los ajustes de la app',
            icon: FeatherIcons.settings,
            onPress: () {
              Get.back();
              Get.to(() => AjustesView());
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
