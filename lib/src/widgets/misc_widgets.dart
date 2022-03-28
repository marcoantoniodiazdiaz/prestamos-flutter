import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:prestamos/src/design/texts.dart';

class MiscWidgets {
  static Widget avatarWithLetter(String letter, double radius, Color color) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: color,
      child: Center(
        child: DesignText(letter, fontSize: 20, color: Colors.white),
      ),
    );
  }
}
