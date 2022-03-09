import 'dart:io';

import 'package:flutter/material.dart';
import 'package:prestamos/src/design/buttons_design.dart';
import 'package:prestamos/src/design/colors_design.dart';
import 'package:prestamos/src/design/input_design.dart';
import 'package:prestamos/src/design/texts.dart';
import 'package:prestamos/src/provider/clientes_provider.dart';
import 'package:prestamos/src/utils/picker_utils.dart';
import 'package:provider/provider.dart';

class NuevoClienteView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final clientesProvider = Provider.of<ClientesProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: DesignColors.dark,
        title: DesignText('Nuevo cliente'),
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: GestureDetector(
                  onTap: () async {
                    final file = await PickerUtils.pickImage();

                    if (file != null) {
                      clientesProvider.profileSelected = File(file.path);
                    }
                  },
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: DesignColors.dark.withOpacity(0.5),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              DesignInput(
                hintText: 'Nombre completo',
                textInputType: TextInputType.text,
                textCapitalization: TextCapitalization.words,
              ),
              SizedBox(height: 7.5),
              DesignInput(
                hintText: 'Dirección',
                textInputType: TextInputType.streetAddress,
                textCapitalization: TextCapitalization.words,
              ),
              SizedBox(height: 7.5),
              DesignInput(
                hintText: 'Ciudad',
                textInputType: TextInputType.text,
                textCapitalization: TextCapitalization.words,
              ),
              SizedBox(height: 7.5),
              DesignInput(
                hintText: 'Telefono',
                textInputType: TextInputType.phone,
              ),
              SizedBox(height: 7.5),
              DesignInput(
                hintText: 'Celular',
                textInputType: TextInputType.phone,
              ),
              SizedBox(height: 7.5),
              DesignInput(
                hintText: 'Correo electronico',
                textInputType: TextInputType.emailAddress,
              ),
              SizedBox(height: 7.5),
              DesignInput(
                hintText: 'Comentario',
                textInputType: TextInputType.text,
                textCapitalization: TextCapitalization.sentences,
                minLines: 3,
              ),
              SizedBox(height: 7.5),
              DesignTextButton(
                width: double.infinity,
                height: 50,
                child: DesignText('Guardar'),
                color: DesignColors.dark,
                primary: Colors.white,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
