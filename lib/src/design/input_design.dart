import 'package:flutter/material.dart';
import 'package:prestamos/src/design/colors_design.dart';

class InputDesignEnterprise extends StatelessWidget {
  final String hintText;
  final TextInputType textInputType;
  final bool? obscureText;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final bool? enabled;
  final int? minLines;
  final TextCapitalization? textCapitalization;
  final Color? fillColor;
  final double? fontSize;
  final TextAlign? textAlign;
  final FocusNode? focusNode;

  const InputDesignEnterprise({
    required this.hintText,
    required this.textInputType,
    this.onChanged,
    this.validator,
    this.obscureText,
    this.fillColor,
    this.enabled,
    this.minLines,
    this.controller,
    this.textCapitalization,
    this.fontSize,
    this.textAlign,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      validator: validator,
      style: TextStyle(fontSize: fontSize),
      obscureText: obscureText ?? false,
      keyboardType: textInputType,
      textCapitalization: textCapitalization ?? TextCapitalization.none,
      controller: controller,
      textAlign: textAlign ?? TextAlign.left,
      minLines: minLines ?? 1,
      maxLines: minLines ?? 1,
      focusNode: focusNode,
      cursorRadius: Radius.circular(10),
      textAlignVertical: TextAlignVertical.top,
      enabled: enabled ?? true,
      cursorColor: DesignColors.dark,
      // cursorHeight: 20,
      cursorWidth: 3,
      decoration: InputDecoration(
        filled: true,
        labelStyle: TextStyle(color: DesignColors.dark),
        fillColor: fillColor ?? DesignColors.dark.withOpacity(0.06),
        hintText: hintText,
        labelText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
