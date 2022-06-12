import 'dart:io';

import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prestamos/src/middlewares/regex_exp.dart';
import 'package:prestamos/src/provider/providers.dart';
import 'package:prestamos/src/provider/users_provider.dart';
import 'package:prestamos/src/utils/picker_utils.dart';

import '../../design/designs.dart';

class NuevoEmpleadoView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: DesignText('Nuevo empleado', fontWeight: FontWeight.bold),
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
    );
  }
}

class _Form extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final usersProvider = Provider.of<UsersProvider>(context);
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: usersProvider.formKey,
      child: Column(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () async {
                  final file = await PickerUtils.pickImage();

                  if (file != null) {
                    usersProvider.profileSelected = File(file.path);
                  }
                },
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: DesignColors.dark.withOpacity(0.5),
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
                  onChanged: (String v) => usersProvider.name = v,
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
            textInputType: TextInputType.emailAddress,
            validator: (String? v) {
              if (v!.isEmpty) return 'Campo vacio';
              if (!RegexExpressions.email.hasMatch(v)) return 'Formato invalido';
              return null;
            },
            onChanged: (String v) => usersProvider.email = v,
          ),
          SizedBox(height: 7.5),
          DesignInput(
            hintText: 'Contraseña',
            textInputType: TextInputType.visiblePassword,
            obscureText: true,
            validator: (String? v) {
              if (v!.isEmpty) return 'Campo vacio';
              if (v.length < 8) return 'Al menos 8 caracteres';
              return null;
            },
            onChanged: (String v) => usersProvider.password = v,
          ),
          SizedBox(height: 7.5),
          DesignTextButton(
            width: double.infinity,
            height: 50,
            child: DesignText('Guardar'),
            color: DesignColors.orange,
            primary: Colors.white,
            onPressed: () => usersProvider.add(),
          ),
        ],
      ),
    );
  }
}
