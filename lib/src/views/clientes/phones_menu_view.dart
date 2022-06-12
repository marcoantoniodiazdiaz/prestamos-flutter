import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:prestamos/src/database/database.dart';
import 'package:prestamos/src/design/designs.dart';
import 'package:prestamos/src/provider/providers.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

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
                        if (!RegExp(r'[0-9]{10,}').hasMatch(v)) {
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
                    color: DesignColors.orange,
                    primary: Colors.white,
                    onPressed: () async {
                      await clientsProvider.addPhone(clientId: model.id);
                    },
                  ),
                ],
              ),
            ),
            _PhoneList(clientId: model.id),
          ],
        ),
      ),
    );
  }
}

class _PhoneList extends StatelessWidget {
  const _PhoneList({required this.clientId});

  final int clientId;

  @override
  Widget build(BuildContext context) {
    final clientsProvider = Provider.of<ClientesProvider>(context);
    final phones = clientsProvider.clients.firstWhere((e) => e.id == clientId).phones;
    return Expanded(
      child: Builder(builder: (_) {
        if (phones.isEmpty) {
          return Center(child: DesignText('Sin telefonos registrados'));
        } else {
          return ListView.builder(
            padding: EdgeInsets.symmetric(vertical: 10),
            itemBuilder: (_, i) {
              return _PhoneItem(model: phones[i]);
            },
            itemCount: phones.length,
          );
        }
      }),
    );
  }
}

class _PhoneItem extends StatelessWidget {
  const _PhoneItem({
    required this.model,
  });

  final PhonesModel model;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => _actionPhone(context, model),
      title: DesignText(model.value),
      subtitle: DesignText('Pulsa para ver opciones'),
      leading: CircleAvatar(
        radius: 23,
        child: Icon(model.type == 0 ? FeatherIcons.phone : Icons.whatsapp, color: Colors.white),
        backgroundColor: model.type == 0 ? DesignColors.pink : Colors.green,
      ),
    );
  }
}

_actionPhone(BuildContext context, PhonesModel phone) {
  return showCupertinoModalBottomSheet(
    context: context,
    builder: (_) {
      return Material(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: CircleAvatar(
                  radius: 25,
                  backgroundColor: DesignColors.pink,
                  child: Icon(FeatherIcons.phoneCall, color: Colors.white),
                ),
                title: DesignText('Llamar ahora'),
                onTap: () async {
                  await FlutterPhoneDirectCaller.callNumber(phone.value);
                },
              ),
              if (phone.type == 1)
                ListTile(
                  leading: CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.green,
                    child: Icon(Icons.whatsapp, color: Colors.white),
                  ),
                  title: DesignText('Enviar Whatsapp'),
                  onTap: () async {
                    final link = WhatsAppUnilink(
                      phoneNumber: '+52-${phone.value}',
                      text: "",
                    );
                    // ignore: deprecated_member_use
                    await launch('$link');
                  },
                ),
            ],
          ),
        ),
      );
    },
  );
}
