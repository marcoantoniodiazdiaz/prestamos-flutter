import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:prestamos/src/database/database.dart';
import 'package:prestamos/src/design/designs.dart';
import 'package:prestamos/src/provider/providers.dart';

class PhonesView extends StatelessWidget {
  final ClientsModel model;

  const PhonesView({required this.model});

  @override
  Widget build(BuildContext context) {
    final clientsProvider = Provider.of<ClientesProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: DesignText(model.name.toUpperCase(), fontWeight: FontWeight.bold),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Form(
        key: clientsProvider.phoneFormKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  Flexible(
                    child: DesignInput(
                      hintText: 'Telefono/Celular',
                      textInputType: TextInputType.phone,
                      onChanged: (v) => clientsProvider.value = v,
                      validator: (v) {
                        if (v!.isEmpty) return 'Campo vacio';
                        if (!RegExp(r'[0-9]{10}').hasMatch(v)) {
                          return 'Eje: 3315856646';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(width: 10),
                  DesignTextButton(
                    width: 80,
                    height: 58,
                    child: Icon(FeatherIcons.save),
                    color: DesignColors.green,
                    primary: Colors.white,
                    onPressed: () async {
                      await clientsProvider.addPhone(clientId: model.id);
                    },
                  ),
                ],
              ),
            ),
            _PhoneList(model: model),
          ],
        ),
      ),
    );
  }
}

class _PhoneList extends StatelessWidget {
  const _PhoneList({required this.model});

  final ClientsModel model;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Builder(builder: (_) {
        if (model.phones.isEmpty) {
          return Center(child: DesignText('Sin telefonos registrados'));
        } else {
          return ListView.builder(
            padding: EdgeInsets.symmetric(vertical: 10),
            physics: BouncingScrollPhysics(),
            itemBuilder: (_, i) {
              return ListTile(
                onLongPress: () {},
                title: DesignText(model.phones[i].value),
                subtitle: DesignText('Pulsa para llamar'),
                leading: CircleAvatar(
                  radius: 23,
                  child: Icon(FeatherIcons.phone, color: Colors.white),
                  backgroundColor: DesignColors.pink,
                ),
              );
            },
            itemCount: model.phones.length,
          );
        }
      }),
    );
  }
}
