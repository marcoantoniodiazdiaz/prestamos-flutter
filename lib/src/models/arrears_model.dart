import 'package:prestamos/src/database/database.dart';

class ArrearsModel {
  ArrearsModel({
    required this.delay,
    required this.loan,
  });

  final int delay;
  final LoansModel loan;

  factory ArrearsModel.fromJson(Map<String, dynamic> json) => ArrearsModel(
        delay: json["delay"],
        loan: LoansModel.fromJson(json["loan"]),
      );

  Map<String, dynamic> toJson() => {
        "delay": delay,
        "loan": loan.toJson(),
      };
}
