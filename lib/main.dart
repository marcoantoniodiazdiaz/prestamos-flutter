import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prestamos/src/provider/accounts_provider.dart';
import 'package:prestamos/src/provider/clientes_provider.dart';
import 'package:prestamos/src/provider/payments_provider.dart';
import 'package:prestamos/src/provider/prestamos_provider.dart';
import 'package:prestamos/src/provider/transactions_provider.dart';
import 'package:prestamos/src/provider/users_provider.dart';
import 'package:prestamos/src/views/home_view.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
        theme: ThemeData(textTheme: GoogleFonts.montserratTextTheme()),
        home: HomeView(),
        // home: VerPrestamosView(),
        defaultTransition: Transition.cupertino,
      ),
    );
  }
}

List<SingleChildWidget> _providers() {
  return [
    ChangeNotifierProvider(create: (_) => PrestamosProvider()),
    ChangeNotifierProvider(create: (_) => AccountsProvider()),
    ChangeNotifierProvider(create: (_) => ClientesProvider()),
    ChangeNotifierProvider(create: (_) => TransactionsProvider()),
    ChangeNotifierProvider(create: (_) => PaymentsProvider()),
    ChangeNotifierProvider(create: (_) => UsersProvider()),
  ];
}
