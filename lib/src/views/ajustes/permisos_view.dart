import 'package:flutter/material.dart';
import 'package:prestamos/src/design/colors_design.dart';
import 'package:prestamos/src/design/texts.dart';

class PermisosView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: DesignColors.dark,
        title: DesignText('Permisos'),
        elevation: 0,
      ),
      body: ListView(
        children: [
          ListTile(
            title: DesignText('Administrativos'),
            trailing: Switch.adaptive(value: true, onChanged: (v) {}, activeColor: Color(0xff3A664A)),
          ),
          ListTile(
            title: DesignText('Consultar'),
            trailing: Switch.adaptive(value: false, onChanged: (v) {}, activeColor: Color(0xff3A664A)),
          ),
          ListTile(
            title: DesignText('Agregar/Editar clientes'),
            trailing: Switch.adaptive(value: false, onChanged: (v) {}, activeColor: Color(0xff3A664A)),
          ),
          ListTile(
            title: DesignText('Borrar pagos'),
            trailing: Switch.adaptive(value: false, onChanged: (v) {}, activeColor: Color(0xff3A664A)),
          ),
          ListTile(
            title: DesignText('Crear pagos'),
            trailing: Switch.adaptive(value: true, onChanged: (v) {}, activeColor: Color(0xff3A664A)),
          ),
          ListTile(
            title: DesignText('Gastos'),
            trailing: Switch.adaptive(value: true, onChanged: (v) {}, activeColor: Color(0xff3A664A)),
          ),
          ListTile(
            title: DesignText('Atrasos'),
            trailing: Switch.adaptive(value: true, onChanged: (v) {}, activeColor: Color(0xff3A664A)),
          ),
          ListTile(
            title: DesignText('Contabilidad'),
            trailing: Switch.adaptive(value: true, onChanged: (v) {}, activeColor: Color(0xff3A664A)),
          ),
        ],
      ),
    );
  }
}
