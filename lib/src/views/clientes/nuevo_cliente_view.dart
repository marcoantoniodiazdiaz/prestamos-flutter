import 'dart:io';

import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prestamos/src/design/designs.dart';
import 'package:prestamos/src/middlewares/regex_exp.dart';
import 'package:prestamos/src/provider/providers.dart';
import 'package:prestamos/src/utils/picker_utils.dart';

class NuevoClienteView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final clientesProvider = Provider.of<ClientesProvider>(context);
    return WillPopScope(
      onWillPop: () async {
        clientesProvider.clean();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: DesignText(clientesProvider.editing != null ? 'Editar cliente' : 'Nuevo cliente', fontWeight: FontWeight.bold),
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
        body: Container(
          padding: EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: _Form(),
          ),
        ),
      ),
    );
  }
}

class _Form extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final clientesProvider = Provider.of<ClientesProvider>(context);
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: clientesProvider.formKey,
      child: Column(
        children: [
          Row(
            children: [
              GestureDetector(
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
                    image: clientesProvider.profileSelected != null
                        ? DecorationImage(
                            fit: BoxFit.cover,
                            image: FileImage(clientesProvider.profileSelected!),
                          )
                        : null,
                  ),
                  child: Center(
                    child: Icon(FeatherIcons.camera, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Flexible(
                child: DesignInput(
                  hintText: 'Nombre completo',
                  controller: clientesProvider.name,
                  validator: (String? v) {
                    if (v!.length < 5) return 'Nombre invalido';
                    return null;
                  },
                  textInputType: TextInputType.text,
                  textCapitalization: TextCapitalization.characters,
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          DesignInput(
            hintText: 'Correo electronico',
            controller: clientesProvider.email,
            textInputType: TextInputType.emailAddress,
            validator: (String? v) {
              if (v!.isEmpty) return 'Campo vacio';
              if (!RegexExpressions.email.hasMatch(v)) return 'Correo electronico invalido';
              return null;
            },
          ),
          SizedBox(height: 7.5),
          DesignInput(
            hintText: 'Comentario',
            textInputType: TextInputType.text,
            controller: clientesProvider.comment,
            textCapitalization: TextCapitalization.characters,
            validator: (String? v) {
              if (v!.isEmpty) return 'Campo vacio';
              return null;
            },
            minLines: 3,
          ),
          SizedBox(height: 7.5),
          DesignTextButton(
            width: double.infinity,
            height: 50,
            child: DesignText('Guardar'),
            color: DesignColors.orange,
            primary: Colors.white,
            onPressed: () => clientesProvider.post(),
          ),
        ],
      ),
    );
  }
}
