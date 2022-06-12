class DurationsUtils {
  static String dhm(int ms) {
    final days = (ms / (24 * 60 * 60 * 1000)).floor();
    final daysms = ms % (24 * 60 * 60 * 1000);
    final hours = (daysms / (60 * 60 * 1000)).floor();
    final hoursms = ms % (60 * 60 * 1000);
    final minutes = (hoursms / (60 * 1000)).floor();
    return '$days dias, $hours horas y $minutes minutos';
  }
}
