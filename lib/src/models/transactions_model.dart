import 'package:prestamos/src/models/accounts_model.dart';

class TransactionsModel {
  TransactionsModel({
    required this.id,
    required this.amount,
    required this.createdAt,
    required this.updatedAt,
    required this.account,
  });

  int id;
  double amount;
  DateTime createdAt;
  DateTime updatedAt;
  AccountsModel account;

  factory TransactionsModel.fromJson(Map<String, dynamic> json) => TransactionsModel(
        id: json["id"],
        amount: json["amount"].toDouble(),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        account: AccountsModel.fromJson(json["account"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "amount": amount,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "account": account.toJson(),
      };
}
