import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prestamos/src/provider/prestamos_provider.dart';
import 'package:prestamos/src/views/prestamos/nuevo_prestamo_view.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PrestamosProvider()),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        theme: ThemeData(textTheme: GoogleFonts.montserratTextTheme()),
        home: NuevoPrestamoView(),
      ),
    );
  }
}