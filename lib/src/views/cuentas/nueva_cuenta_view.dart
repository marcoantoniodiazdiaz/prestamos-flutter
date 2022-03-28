import 'dart:io';

import 'package:flutter/material.dart';
import 'package:prestamos/src/design/buttons_design.dart';
import 'package:prestamos/src/design/colors_design.dart';
import 'package:prestamos/src/design/input_design.dart';
import 'package:prestamos/src/design/texts.dart';
import 'package:prestamos/src/provider/clientes_provider.dart';
import 'package:prestamos/src/utils/picker_utils.dart';
import 'package:provider/provider.dart';

class NuevaCuentaView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final clientesProvider = Provider.of<ClientesProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: DesignColors.dark,
        title: DesignText('Nuevo cuenta'),
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            DesignInput(
              hintText: 'Nombre',
              textInputType: TextInputType.streetAddress,
              textCapitalization: TextCapitalization.words,
            ),
            Expanded(child: SizedBox()),
            SafeArea(
              child: DesignTextButton(
                width: double.infinity,
                height: 50,
                child: DesignText('Guardar'),
                color: DesignColors.dark,
                primary: Colors.white,
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
