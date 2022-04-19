import 'package:flutter/material.dart';
import 'package:prestamos/src/design/designs.dart';

class PermisosView extends StatelessWidget {
  final String username;

  const PermisosView({required this.username});

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
          SizedBox(height: 10),
          ListTile(
            leading: CircleAvatar(
              radius: 23,
            ),
            title: DesignText('Permisos de $username'),
          ),
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
