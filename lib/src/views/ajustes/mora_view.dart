import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prestamos/src/design/designs.dart';
import 'package:prestamos/src/middlewares/validators.dart';
import 'package:prestamos/src/provider/providers.dart';
import 'package:prestamos/src/provider/settings_provider.dart';

class MoraView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final settinsProvider = Provider.of<SettingsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: DesignText('Mora', fontWeight: FontWeight.bold),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            DesignInput(
              hintText: 'Ajustar mora por cada dia de restraso',
              textInputType: TextInputType.number,
              onChanged: (v) {
                settinsProvider.mora = v;
              },
            ),
            SizedBox(height: 20),
            DesignTextButton(
              width: double.infinity,
              height: 50,
              child: DesignText('Actualizar mora'),
              color: DesignColors.green,
              primary: Colors.white,
              onPressed: () => settinsProvider.updateMora(),
            ),
            SizedBox(height: 10),
            DesignText('La mora actual es: \$${settinsProvider.mora}', fontStyle: FontStyle.italic),
          ],
        ),
      ),
    );
  }
}
