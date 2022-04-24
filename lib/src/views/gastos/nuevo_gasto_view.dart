import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prestamos/src/design/buttons_design.dart';
import 'package:prestamos/src/design/colors_design.dart';
import 'package:prestamos/src/design/input_design.dart';
import 'package:prestamos/src/design/texts.dart';
import 'package:prestamos/src/provider/accounts_provider.dart';
import 'package:prestamos/src/provider/providers.dart';

class NuevoGastoView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final expensesProvider = Provider.of<ExpensesProvider>(context);
    final accountsProvider = Provider.of<AccountsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: DesignText('Nuevo gasto', fontWeight: FontWeight.bold),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.all(15),
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: expensesProvider.formKey,
          child: Column(
            children: [
              DesignInput(
                hintText: 'Nombre',
                textInputType: TextInputType.streetAddress,
                textCapitalization: TextCapitalization.characters,
                onChanged: (String v) => expensesProvider.name = v,
                validator: (String? v) {
                  v ??= '';
                  if (v.isEmpty || v.length < 3) {
                    return 'Campo demaciado corto';
                  }

                  return null;
                },
              ),
              SizedBox(height: 10),
              DesignInput(
                hintText: 'Descripción',
                textInputType: TextInputType.streetAddress,
                textCapitalization: TextCapitalization.characters,
                minLines: 3,
                onChanged: (String v) => expensesProvider.description = v,
                validator: (String? v) {
                  v ??= '';
                  if (v.isEmpty || v.length < 3) {
                    return 'Campo demaciado corto';
                  }

                  return null;
                },
              ),
              SizedBox(height: 10),
              DesignInput(
                hintText: 'Monto',
                textInputType: TextInputType.number,
                onChanged: (String v) => expensesProvider.amount = v,
                validator: (String? v) {
                  v ??= '';
                  if (!RegExp(r'^[0-9]{1,10}(\.[0-9]{1,2})?$').hasMatch(v)) return 'Monto invalido';

                  return null;
                },
              ),
              SizedBox(height: 10),
              Builder(builder: (context) {
                // if (accountsProvider.accounts.isEmpty) {
                if (accountsProvider.accounts.isEmpty) {
                  return DesignText('Cargando cuentas');
                } else {
                  return Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: DesignColors.dark.withOpacity(0.06),
                    ),
                    child: DropdownButton<int>(
                      items: [
                        DropdownMenuItem(child: DesignText('No seleccionada'), value: -1),
                        ...accountsProvider.accounts.map((e) {
                          return DropdownMenuItem(child: DesignText(e.name), value: e.id);
                        }).toList()
                      ],
                      underline: SizedBox(),
                      onChanged: (int? v) {
                        expensesProvider.accountId = v!;
                        expensesProvider.repaint();
                      },
                      isExpanded: true,
                      value: expensesProvider.accountId,
                    ),
                  );
                }
              }),
              SizedBox(height: 10),
              SafeArea(
                child: DesignTextButton(
                  width: double.infinity,
                  height: 50,
                  child: DesignText('Guardar gasto'),
                  color: DesignColors.blue,
                  primary: Colors.white,
                  onPressed: () => expensesProvider.post(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
