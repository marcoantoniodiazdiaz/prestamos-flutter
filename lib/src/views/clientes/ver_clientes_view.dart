import 'package:flutter/material.dart';
import 'package:prestamos/src/design/colors_design.dart';
import 'package:prestamos/src/design/texts.dart';
import 'package:prestamos/src/pipes/image_pipe.dart';

class VerClientesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: DesignColors.dark,
        title: DesignText('Todos los clientes'),
        elevation: 0,
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 10),
        physics: BouncingScrollPhysics(),
        itemBuilder: (_, index) {
          return ListTile(
            title: DesignText('Marco Diaz'),
            leading: CircleAvatar(
              radius: 23,
              backgroundImage: ImagePipes.assetOrNetwork(),
            ),
          );
        },
        itemCount: 20,
      ),
    );
  }
}
