import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoadingUtils {
  static showLoading() {
    return showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (context) {
        return Center(
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: CupertinoActivityIndicator(radius: 15),
          ),
        );
      },
    );
  }
}
