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
      borderRadius: 10,
      isDismissible: true,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red.withOpacity(0.9),
      colorText: Colors.white,
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
