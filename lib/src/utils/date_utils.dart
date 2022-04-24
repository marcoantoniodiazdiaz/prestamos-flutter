class DesignUtils {
  static String dateShort(DateTime time) {
    time = time.toLocal();
    return '${time.day}-${intToMonthShort(time.month)}-${time.year}';
  }

  static String dateShortWithHour(DateTime time) {
    time = time.toLocal();
    return '${time.day}-${intToMonthShort(time.month)}-${time.year} ${_hourNormalize(time.hour, time.minute)}';
  }

  static String intToMonthShort(int number) {
    final months = {
      1: 'ENE',
      2: 'FEB',
      3: 'MAR',
      4: 'ABR',
      5: 'MAY',
      6: 'JUN',
      7: 'JUL',
      8: 'AGO',
      9: 'SEP',
      10: 'OCT',
      11: 'NOV',
      12: 'DIC',
    };

    return months[number]!;
  }
}

String _hourNormalize(int hour, int minute) {
  if (hour <= 12) return '$hour:$minute A.M.';
  hour -= 12;

  return '$hour:$minute P.M.';
}
