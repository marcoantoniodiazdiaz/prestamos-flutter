class ParsersUtils {
  static money(double amount) {
    return '\$${amount.toStringAsFixed(2)}';
  }

  static double getPercent(double x, double y) {
    return y / x;
  }

  static String capitalize(String str) {
    return str.capitalize();
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
