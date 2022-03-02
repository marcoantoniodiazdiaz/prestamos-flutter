import 'package:flutter/material.dart';

class DesignText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final TextAlign? textAlign;
  final FontWeight? fontWeight;
  final Color? color;
  final String? fontFamily;
  final FontStyle? fontStyle;
  final double? letterSpacing;
  final TextOverflow? textOverflow;
  final TextDecoration? textDecorationStyle;

  const DesignText(this.text,
      {this.fontSize,
      this.textAlign,
      this.fontWeight,
      this.color,
      this.fontStyle,
      this.fontFamily,
      this.letterSpacing,
      this.textOverflow,
      this.textDecorationStyle});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
          letterSpacing: letterSpacing ?? -0.5,
          height: 1,
          fontSize: fontSize,
          overflow: textOverflow,
          fontWeight: fontWeight,
          decoration: textDecorationStyle,
          color: color,
          fontStyle: fontStyle,
          fontFamily: fontFamily),
    );
  }
}
