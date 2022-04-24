import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prestamos/src/database/database.dart';
import 'package:prestamos/src/design/designs.dart';
import 'package:prestamos/src/provider/providers.dart';

class NuevoEmpenoView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: DesignText('Nuevo empeño', fontWeight: FontWeight.bold),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Form(
        // key: clientsProvider.phoneFormKey,
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
                      // onChanged: (v) => clientsProvider.value = v,
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
                    color: DesignColors.green,
                    primary: Colors.white,
                    onPressed: () async {
                      // await clientsProvider.addPhone(clientId: model.id);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
