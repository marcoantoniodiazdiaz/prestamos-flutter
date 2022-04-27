import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prestamos/src/database/preferences.dart';
import 'package:prestamos/src/design/texts.dart';
import 'package:prestamos/src/pipes/image_pipe.dart';
import 'package:prestamos/src/utils/parsers_utils.dart';
import 'package:prestamos/src/views/ajustes/ajustes_view.dart';
import 'package:prestamos/src/views/atrasos/atrasos_view.dart';
import 'package:prestamos/src/views/auth/login_view.dart';
import 'package:prestamos/src/views/clientes/clientes_menu.dart';
import 'package:prestamos/src/views/clientes/nuevo_cliente_view.dart';
import 'package:prestamos/src/views/cuentas/cuentas_view.dart';
import 'package:prestamos/src/views/empleados/empleados_menu.dart';
import 'package:prestamos/src/views/gastos/gastos_menu.dart';
import 'package:prestamos/src/views/prestamos/prestamos_menu.dart';

class DrawerDesign extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Container(
        padding: EdgeInsets.only(left: 5),
        child: Column(
          children: [
            SizedBox(height: 70),
            CircleAvatar(
              radius: 40,
              backgroundImage: ImagePipes.assetOrNetwork(url: UserPreferences.photo),
            ),
            SizedBox(height: 10),
            DesignText(ParsersUtils.capitalize(UserPreferences.name), color: Colors.black, fontSize: 15),
            SizedBox(height: 20),
            _ListTile(
              title: 'Prestamos',
              subtitle: 'Crear, registrar prestamos',
              icon: FeatherIcons.dollarSign,
              onPress: () {
                Get.back();
                Get.to(() => PrestamosMenu());
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
                Get.to(() => AtrasosView());
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
                Get.to(() => GastosMenu());
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
                Get.offAll(() => LoginView());
              },
            ),
          ],
        ),
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
            Icon(icon),
            SizedBox(width: 20),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DesignText(title),
                  SizedBox(height: 5),
                  DesignText(
                    subtitle,
                    color: Colors.black54,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
