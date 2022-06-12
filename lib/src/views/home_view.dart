import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:prestamos/src/database/preferences.dart';
import 'package:prestamos/src/design/designs.dart';
import 'package:prestamos/src/middlewares/go_page.dart';
import 'package:prestamos/src/pipes/image_pipe.dart';
import 'package:prestamos/src/utils/parsers_utils.dart';
import 'package:prestamos/src/views/ajustes/ajustes_view.dart';
import 'package:prestamos/src/views/atrasos/atrasos_view.dart';
import 'package:prestamos/src/views/auth/login_view.dart';
import 'package:prestamos/src/views/clientes/clientes_menu.dart';
import 'package:prestamos/src/views/clientes/nuevo_cliente_view.dart';
import 'package:prestamos/src/views/consultas/queries_view.dart';
import 'package:prestamos/src/views/cuentas/cuentas_view.dart';
import 'package:prestamos/src/views/empleados/empleados_menu.dart';
import 'package:prestamos/src/views/gastos/gastos_menu.dart';
import 'package:prestamos/src/views/moras/moras_view.dart';
import 'package:prestamos/src/views/prestamos/prestamos_menu.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        DesignText(
                          'Hola ${ParsersUtils.capitalize(UserPreferences.name).split(' ')[0]}',
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ],
                    ),
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: ImagePipes.assetOrNetwork(url: UserPreferences.photo),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                DesignText('Menu de acciones', fontWeight: FontWeight.bold, fontSize: 20),
                SizedBox(height: 10),
                GridView.count(
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  children: [
                    _MenuItem(
                      title: 'Prestamos',
                      subtitle: 'Crear, registrar prestamos',
                      icon: FeatherIcons.dollarSign,
                      onPress: () {
                        Get.to(() => PrestamosMenu());
                      },
                    ),
                    _MenuItem(
                      title: 'Clientes',
                      subtitle: 'Crear y ver información de clientes',
                      icon: FeatherIcons.user,
                      onPress: () {
                        // Get.to(() => NuevoClienteView());
                        Get.to(() => ClientesMenu());
                      },
                    ),
                    _MenuItem(
                      title: 'Consultas',
                      subtitle: 'Mostrar información filtrada por campos',
                      icon: FeatherIcons.sliders,
                      onPress: () => GoToMiddleware.goTo(QueriesView(), 4),
                      // onPress: () {
                      //   Get.to(() => QueriesView());
                      // },
                    ),
                    _MenuItem(
                      title: 'Cuentas',
                      subtitle: 'Crear y ver cuentas generadas',
                      icon: FeatherIcons.inbox,
                      onPress: () => Get.to(() => CuentasView()),
                    ),
                    _MenuItem(
                      title: 'Atrasos',
                      subtitle: 'Revisar pagos tardios y retrasados',
                      icon: FeatherIcons.skipBack,
                      onPress: () => GoToMiddleware.goTo(AtrasosView(), 7),
                    ),
                    _MenuItem(
                      title: 'Moras',
                      subtitle: 'Mostrar todas las moras registradas',
                      icon: FeatherIcons.refreshCw,
                      onPress: () => GoToMiddleware.goTo(MorasView(), 16),
                    ),
                    _MenuItem(
                      title: 'Gastos',
                      subtitle: 'Mostrar gastos realizados',
                      icon: FeatherIcons.arrowDown,
                      onPress: () {
                        Get.to(() => GastosMenu());
                      },
                    ),
                    _MenuItem(
                      title: 'Empleados',
                      subtitle: 'Crear y ver información de empleados',
                      icon: FeatherIcons.users,
                      onPress: () {
                        Get.to(() => EmpleadosMenuView());
                      },
                    ),
                    _MenuItem(
                      title: 'Ajustes',
                      subtitle: 'Edita los ajustes de la app',
                      icon: FeatherIcons.settings,
                      onPress: () {
                        Get.to(() => AjustesView());
                      },
                    ),
                    _MenuItem(
                      title: 'Cerrar sesión',
                      subtitle: 'Cambiar de perfil',
                      icon: FeatherIcons.logOut,
                      onPress: () {
                        UserPreferences.clear();
                        Get.offAll(() => LoginView());
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final void Function() onPress;

  const _MenuItem({required this.title, required this.subtitle, required this.icon, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.black.withOpacity(0.2),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onPress,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: DesignColors.orange,
                radius: 25,
                child: Icon(icon, color: Colors.white, size: 30),
              ),
              SizedBox(height: 10),
              DesignText(title, fontWeight: FontWeight.bold, fontSize: 20),
              SizedBox(height: 10),
              DesignText(subtitle, fontSize: 15, textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}
