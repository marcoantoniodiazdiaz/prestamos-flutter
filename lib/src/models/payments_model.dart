import 'package:prestamos/src/models/transactions_model.dart';

class PaymentsModel {
  PaymentsModel({
    required this.id,
    required this.location,
    required this.createdAt,
    required this.updatedAt,
    required this.transaction,
  });

  int id;
  String location;
  DateTime createdAt;
  DateTime updatedAt;
  TransactionsModel transaction;

  factory PaymentsModel.fromJson(Map<String, dynamic> json) => PaymentsModel(
        id: json["id"],
        location: json["location"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        transaction: TransactionsModel.fromJson(json["transaction"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "location": location,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "transaction": transaction.toJson(),
      };
}
