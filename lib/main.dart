import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prestamos/src/database/preferences.dart';
import 'package:prestamos/src/design/colors_design.dart';
import 'package:prestamos/src/provider/accounts_provider.dart';
import 'package:prestamos/src/provider/actions_provider.dart';
import 'package:prestamos/src/provider/arrears_provider.dart';
import 'package:prestamos/src/provider/auth_provider.dart';
import 'package:prestamos/src/provider/clientes_provider.dart';
import 'package:prestamos/src/provider/directions_provider.dart';
import 'package:prestamos/src/provider/expenses_provider.dart';
import 'package:prestamos/src/provider/moras_provider.dart';
import 'package:prestamos/src/provider/payments_provider.dart';
import 'package:prestamos/src/provider/prestamos_provider.dart';
import 'package:prestamos/src/provider/providers.dart';
import 'package:prestamos/src/provider/settings_provider.dart';
import 'package:prestamos/src/provider/stadistics_provider.dart';
import 'package:prestamos/src/provider/transactions_provider.dart';
import 'package:prestamos/src/provider/users_provider.dart';
import 'package:prestamos/src/views/auth/login_view.dart';
import 'package:prestamos/src/views/direcciones/nueva_direccion_view.dart';
import 'package:prestamos/src/views/home_view.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserPreferences().initPrefs();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // transparent status bar
  ));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: _providers(),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        theme: ThemeData(
          textTheme: GoogleFonts.aBeeZeeTextTheme(),
          useMaterial3: true,
          primaryColor: DesignColors.orange,
        ),
        home: whatPage(),
        defaultTransition: Transition.cupertino,
      ),
    );
  }
}

Widget whatPage() {
  if (UserPreferences.token.isEmpty) {
    return LoginView();
  } else {
    return HomeView();
  }
}

List<SingleChildWidget> _providers() {
  return [
    ChangeNotifierProvider(create: (_) => ActionsProvider(), lazy: false),
    ChangeNotifierProvider(create: (_) => PrestamosProvider()),
    ChangeNotifierProvider(create: (_) => AccountsProvider()),
    ChangeNotifierProvider(create: (_) => DirectionsProvider()),
    ChangeNotifierProvider(create: (_) => ClientesProvider()),
    ChangeNotifierProvider(create: (_) => ProductsProvider()),
    ChangeNotifierProvider(create: (_) => MorasProvider()),
    ChangeNotifierProvider(create: (_) => AtrasosProvider()),
    ChangeNotifierProvider(create: (_) => ArrearsProvider()),
    ChangeNotifierProvider(create: (_) => AuthProvider()),
    ChangeNotifierProvider(create: (_) => EmpenosProvider()),
    ChangeNotifierProvider(create: (_) => ExpensesProvider()),
    ChangeNotifierProvider(create: (_) => SettingsProvider()),
    ChangeNotifierProvider(create: (_) => StadisticsProvider()),
    ChangeNotifierProvider(create: (_) => TransactionsProvider()),
    ChangeNotifierProvider(create: (_) => PaymentsProvider()),
    ChangeNotifierProvider(create: (_) => UsersProvider()),
  ];
}
