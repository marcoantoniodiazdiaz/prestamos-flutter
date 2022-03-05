class DesignUtils {
  static String dateShort(DateTime time) {
    time = time.toLocal();
    return '${time.day}-${intToMonthShort(time.month)}-${time.year}';
  }

  static String intToMonthShort(int number) {
    final months = {
      1: 'ene',
      2: 'feb',
      3: 'mar',
      4: 'abr',
      5: 'may',
      6: 'jun',
      7: 'jul',
      8: 'ago',
      9: 'sep',
      10: 'oct',
      11: 'nov',
      12: 'dic',
    };

    return months[number]!;
  }
}
