import 'package:flutter/material.dart';

class DesignUtils {
  static String dateShort(DateTime time) {
    time = time.toLocal();
    return '${time.day}-${time.month}-${time.year}';
  }
}
