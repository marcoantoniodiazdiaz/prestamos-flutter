class LoanPreview {
  LoanPreview({
    required this.now,
    required this.top,
    required this.days,
    required this.items,
    required this.payDays,
  });

  final DateTime now;
  final DateTime top;
  final int days;
  final List<LoanPreviewItem> items;
  final List<DateTime> payDays;

  factory LoanPreview.fromJson(Map<String, dynamic> json) => LoanPreview(
        now: DateTime.parse(json["now"]),
        top: DateTime.parse(json["top"]),
        days: json["days"],
        items: List<LoanPreviewItem>.from(json["items"].map((x) => LoanPreviewItem.fromJson(x))),
        payDays: List<DateTime>.from(json["payDays"].map((x) => DateTime.parse(x))),
      );

  Map<String, dynamic> toJson() => {
        "now": now.toIso8601String(),
        "top": top.toIso8601String(),
        "days": days,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "payDays": List<dynamic>.from(payDays.map((x) => x.toIso8601String())),
      };
}

class LoanPreviewItem {
  LoanPreviewItem({
    required this.datetime,
    required this.isPayDay,
  });

  final DateTime datetime;
  final bool isPayDay;

  factory LoanPreviewItem.fromJson(Map<String, dynamic> json) => LoanPreviewItem(
        datetime: DateTime.parse(json["datetime"]),
        isPayDay: json["isPayDay"],
      );

  Map<String, dynamic> toJson() => {
        "datetime": datetime.toIso8601String(),
        "isPayDay": isPayDay,
      };
}
