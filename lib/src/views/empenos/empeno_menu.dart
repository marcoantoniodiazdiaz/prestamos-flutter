import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prestamos/src/design/designs.dart';
import 'package:prestamos/src/views/empenos/nuevo_empeno_view.dart';
import 'package:prestamos/src/views/productos/nuevo_producto_view.dart';

class EmpenoMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: EdgeInsets.all(20),
        child: SafeArea(
          child: Row(
            children: [
              Expanded(
                child: DesignTextButton(
                  width: double.infinity,
                  height: 80,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(FeatherIcons.box),
                      SizedBox(height: 5),
                      DesignText('Producto existente'),
                    ],
                  ),
                  color: DesignColors.green,
                  primary: Colors.white,
                  onPressed: () {
                    Get.back();
                    Get.to(() => NuevoEmpenoView());
                  },
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: DesignTextButton(
                  width: double.infinity,
                  height: 80,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(FeatherIcons.plusSquare),
                      SizedBox(height: 5),
                      DesignText('Nuevo producto'),
                    ],
                  ),
                  color: DesignColors.pink,
                  primary: Colors.white,
                  onPressed: () {
                    Get.back(); // Close current modal
                    Get.to(() => NuevoProductoView());
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
