import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prestamos/src/design/buttons_design.dart';
import 'package:prestamos/src/design/colors_design.dart';
import 'package:prestamos/src/design/input_design.dart';
import 'package:prestamos/src/design/texts.dart';
import 'package:prestamos/src/provider/accounts_provider.dart';
import 'package:prestamos/src/provider/providers.dart';

class NuevaCuentaView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final accountsProvider = Provider.of<AccountsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: DesignText('Nueva cuenta', fontWeight: FontWeight.bold),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: accountsProvider.formKey,
          child: Column(
            children: [
              DesignInput(
                hintText: 'Nombre',
                textInputType: TextInputType.streetAddress,
                textCapitalization: TextCapitalization.characters,
                onChanged: (String v) => accountsProvider.name = v,
                validator: (String? v) {
                  v ??= '';
                  if (v.isEmpty || v.length < 3) {
                    return 'Campo demaciado corto';
                  }

                  if (accountsProvider.accounts.map((e) => e.name).contains(v)) {
                    return 'Esta cuenta ya existe';
                  }

                  return null;
                },
              ),
              Expanded(child: SizedBox()),
              SafeArea(
                child: DesignTextButton(
                  width: double.infinity,
                  height: 50,
                  child: DesignText('Guardar cuenta'),
                  color: DesignColors.blue,
                  primary: Colors.white,
                  onPressed: () => accountsProvider.add(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
