class ParsersUtils {
  static money(double amount) {
    return '\$${amount.toStringAsFixed(2)}';
  }

  static double getPercent(double x, double y) {
    return y / x;
  }
}
