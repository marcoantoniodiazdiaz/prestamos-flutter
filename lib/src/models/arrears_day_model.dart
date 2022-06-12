class ArrearDayModel {
  ArrearDayModel({
    required this.date,
    required this.cutDay,
    required this.daylyAmount,
    required this.covered,
  });

  final DateTime date;
  final bool cutDay;
  final double daylyAmount;
  final bool covered;

  factory ArrearDayModel.fromJson(Map<String, dynamic> json) => ArrearDayModel(
        date: DateTime.parse(json["date"]),
        cutDay: json["cutDay"],
        daylyAmount: json["daylyAmount"].toDouble(),
        covered: json["covered"],
      );
}
