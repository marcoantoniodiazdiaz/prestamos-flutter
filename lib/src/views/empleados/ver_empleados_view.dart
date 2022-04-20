import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:prestamos/src/database/database.dart';
import 'package:prestamos/src/design/designs.dart';
import 'package:prestamos/src/pipes/image_pipe.dart';
import 'package:prestamos/src/provider/providers.dart';
import 'package:prestamos/src/provider/users_provider.dart';
import 'package:prestamos/src/utils/date_utils.dart';
import 'package:prestamos/src/views/empleados/permisos_view.dart';

class VerEmpleadosView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final usersProvider = Provider.of<UsersProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: DesignText('Todos los empleados', fontWeight: FontWeight.bold),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 10),
        physics: BouncingScrollPhysics(),
        itemBuilder: (_, index) {
          return ListTile(
            title: DesignText(usersProvider.users[index].name.toUpperCase()),
            leading: CircleAvatar(
              radius: 23,
              backgroundImage: ImagePipes.assetOrNetwork(url: usersProvider.users[index].image),
            ),
            onTap: () {
              _showWorkerInformation(usersProvider.users[index]);
            },
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
        itemCount: usersProvider.users.length,
      ),
    );
  }
}

_showWorkerInformation(UsersModel model) {
  return showCupertinoModalBottomSheet(
    context: Get.context!,
    builder: (_) {
      return Material(
        child: Container(
          padding: EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              DesignText('Nombre: ', fontSize: 12, color: Colors.black45),
              SizedBox(height: 5),
              DesignText(
                model.name.toUpperCase(),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(height: 10),
              DesignText('Correo electronico: ', fontSize: 12, color: Colors.black45),
              SizedBox(height: 5),
              DesignText(
                model.email,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(height: 10),
              DesignText('Registrado: ', fontSize: 12, color: Colors.black45),
              SizedBox(height: 5),
              DesignText(
                DesignUtils.dateShort(model.createdAt),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      );
    },
  );
}
