import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prestamos/src/design/buttons_design.dart';
import 'package:prestamos/src/design/colors_design.dart';
import 'package:prestamos/src/design/texts.dart';
import 'package:prestamos/src/views/empleados/permisos_view.dart';

class VerEmpleadosView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: DesignColors.dark,
        title: DesignText('Todos los empleados'),
        elevation: 0,
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 10),
        physics: BouncingScrollPhysics(),
        itemBuilder: (_, index) {
          return ListTile(
            title: DesignText('Marco Diaz'),
            leading: CircleAvatar(
              radius: 23,
            ),
            subtitle: DesignText('Manten pulsado para editar'),
            trailing: DesignTextButton(
              width: 80,
              height: 35,
              child: DesignText('Permisos'),
              color: DesignColors.green,
              primary: Colors.white,
              onPressed: () {
                Get.to(() => PermisosView(username: 'Marco Diaz'));
              },
            ),
          );
        },
        itemCount: 20,
      ),
    );
  }
}
