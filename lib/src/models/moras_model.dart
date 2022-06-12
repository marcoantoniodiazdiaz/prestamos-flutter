import 'package:prestamos/src/database/database.dart';

class MorasModel {
  MorasModel({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.loan,
    required this.transaction,
  });

  int id;
  DateTime createdAt;
  DateTime updatedAt;
  LoansModel loan;
  TransactionsModel transaction;

  factory MorasModel.fromJson(Map<String, dynamic> json) => MorasModel(
        id: json["id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        loan: LoansModel.fromJson(json["loan"]),
        transaction: TransactionsModel.fromJson(json["transaction"]),
      );
}
