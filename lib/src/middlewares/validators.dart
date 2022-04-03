class Validators {
  static notEmpty(String? v) {
    if (v == null) return null;
    if (v.isEmpty) return 'Campo vacio';
    return null;
  }
}
