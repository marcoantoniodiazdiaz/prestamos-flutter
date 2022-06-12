import 'package:flutter/widgets.dart';

class InputFunctions {
  static String? Function(String?)? regexValidator({
    required String onRegexError,
    String? regex,
    RegExp? localValidators,
  }) {
    return (String? v) {
      if (regex == null && localValidators == null) {
        throw 'Incorrect use of this function, regex && localValidators cannot be null';
      }
      if (v == null) return 'Campo invalido';
      if (v.isEmpty) return 'Campo vacio';
      if (localValidators == null ? !RegExp(regex!).hasMatch(v) : !localValidators.hasMatch(v)) {
        return onRegexError;
      }

      return null;
    };
  }

  static validate(GlobalKey<FormState>? formKey) {
    if (formKey == null) return false;
    if (formKey.currentState == null) return false;
    return formKey.currentState?.validate() ?? false;
  }
}

class LocalValidators {
  static final RegExp integer = RegExp(r'^[0-9]+$');
  static final RegExp decimal = RegExp(r'^[0-9]+(.[0-9]+)?$');
  static final RegExp notEmpty = RegExp(r'^.+$');
  static final RegExp email = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  static final RegExp password = RegExp(r'^.{8,}$');
  static final RegExp phone = RegExp(r'^[0-9]{10}$');
  static final RegExp any = RegExp(r'^.*$');
  static final RegExp date = RegExp(r'^[\d]{2}\/[\d]{2}\/[\d]{4}$');
  static RegExp absoluteLength(int n) => RegExp('^.{$n}\$');
}
