class StructuresUtils {
  static double sum(Iterable<double> list) {
    double sum = 0;
    for (final e in list) {
      sum += e;
    }

    return sum;
  }
}
