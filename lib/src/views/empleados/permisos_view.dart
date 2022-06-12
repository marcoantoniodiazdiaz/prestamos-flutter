import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prestamos/src/database/database.dart';
import 'package:prestamos/src/database/preferences.dart';
import 'package:prestamos/src/design/designs.dart';
import 'package:prestamos/src/models/permissions_model.dart';
import 'package:prestamos/src/pipes/image_pipe.dart';
import 'package:prestamos/src/provider/actions_provider.dart';
import 'package:prestamos/src/provider/providers.dart';

class PermisosView extends StatelessWidget {
  final UsersModel model;

  const PermisosView({required this.model});

  @override
  Widget build(BuildContext context) {
    final actionsProvider = Provider.of<ActionsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: DesignText('Permisos', fontWeight: FontWeight.bold),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: ListView(
        children: [
          SizedBox(height: 10),
          ListTile(
            leading: CircleAvatar(
              radius: 23,
              backgroundImage: ImagePipes.assetOrNetwork(url: model.image),
            ),
            title: DesignText('Permisos de ${model.name}'),
          ),
          ...actionsProvider.actions.map((e) {
            return _Action(user: model, permission: e);
          }),
        ],
      ),
    );
  }
}

class _Action extends StatelessWidget {
  final PermissionsModel permission;
  final UsersModel user;

  const _Action({required this.permission, required this.user});

  @override
  Widget build(BuildContext context) {
    final actionsProvider = Provider.of<ActionsProvider>(context);
    return ListTile(
      title: DesignText(permission.action.name),
      trailing: Switch.adaptive(
        value: permission.has,
        onChanged: (v) {
          actionsProvider.changeStatusPermission(user, permission);
        },
        activeColor: DesignColors.orange,
      ),
    );
  }
}
