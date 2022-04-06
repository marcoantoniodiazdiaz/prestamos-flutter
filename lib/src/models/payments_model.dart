import 'package:prestamos/src/models/transactions_model.dart';
import 'package:prestamos/src/models/users_model.dart';

class PaymentsModel {
  PaymentsModel({
    required this.id,
    required this.location,
    required this.createdAt,
    required this.updatedAt,
    required this.transaction,
    required this.user,
  });

  int id;
  String location;
  DateTime createdAt;
  DateTime updatedAt;
  TransactionsModel transaction;
  UsersModel user;

  factory PaymentsModel.fromJson(Map<String, dynamic> json) => PaymentsModel(
        id: json["id"],
        location: json["location"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        transaction: TransactionsModel.fromJson(json["transaction"]),
        user: UsersModel.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "location": location,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "transaction": transaction.toJson(),
        "user": user.toJson(),
      };
}
