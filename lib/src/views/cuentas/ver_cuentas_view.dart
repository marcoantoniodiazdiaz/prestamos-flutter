import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prestamos/src/design/colors_design.dart';
import 'package:prestamos/src/design/texts.dart';
import 'package:prestamos/src/provider/accounts_provider.dart';
import 'package:prestamos/src/provider/providers.dart';
import 'package:prestamos/src/widgets/misc_widgets.dart';

class VerCuentasView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final accountsProvider = Provider.of<AccountsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: DesignText('Todos las cuentas', fontWeight: FontWeight.bold),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 10),
        itemBuilder: (_, index) {
          return ListTile(
            title: DesignText(accountsProvider.accounts[index].name),
            leading: MiscWidgets.avatarWithLetter(accountsProvider.accounts[index].name[0], 25, DesignColors.orange),
            onTap: () {},
            subtitle: DesignText('Manten pulsado para editar'),
          );
        },
        itemCount: accountsProvider.accounts.length,
      ),
    );
  }
}
