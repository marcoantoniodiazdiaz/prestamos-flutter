import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackBarUtils {
  static snackBarWarning(String message) {
    Get.snackbar(
      'Advertencia',
      message,
      animationDuration: Duration(milliseconds: 300),
      borderRadius: 10,
      isDismissible: true,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.orange.withOpacity(0.9),
      colorText: Colors.white,
      margin: EdgeInsets.all(10),
    );
  }

  static snackBarError(String message) {
    Get.snackbar(
      'Error',
      message,
      animationDuration: Duration(milliseconds: 300),
      borderRadius: 0,
      isDismissible: true,
      boxShadows: [BoxShadow(blurRadius: 5, color: Colors.black.withOpacity(0.08), spreadRadius: 5)],
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.black.withOpacity(0.9),
      icon: Icon(FeatherIcons.x, color: Colors.red),
      leftBarIndicatorColor: Colors.red,
      colorText: Colors.white,
      shouldIconPulse: false,
      margin: EdgeInsets.all(10),
    );
  }

  static snackBarSuccess(String message) {
    Get.snackbar(
      'Exito',
      message,
      animationDuration: Duration(milliseconds: 300),
      borderRadius: 10,
      isDismissible: true,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green.withOpacity(0.9),
      colorText: Colors.white,
      margin: EdgeInsets.all(10),
    );
  }

  static snackBar(String title, String message, Color color) {
    Get.snackbar(
      title,
      message,
      animationDuration: Duration(milliseconds: 300),
      borderRadius: 10,
      isDismissible: true,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: color,
      colorText: Colors.white,
      margin: EdgeInsets.all(10),
    );
  }
}
