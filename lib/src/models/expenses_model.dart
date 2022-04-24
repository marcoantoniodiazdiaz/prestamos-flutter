// To parse this JSON data, do
//
//     final expensesModel = expensesModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

import 'package:prestamos/src/database/database.dart';

ExpensesModel expensesModelFromJson(String str) => ExpensesModel.fromJson(json.decode(str));

String expensesModelToJson(ExpensesModel data) => json.encode(data.toJson());

class ExpensesModel {
  ExpensesModel({
    required this.id,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.transaction,
    required this.user,
  });

  int id;
  String name;
  String description;
  DateTime createdAt;
  DateTime updatedAt;
  TransactionsModel transaction;
  UsersModel user;

  factory ExpensesModel.fromJson(Map<String, dynamic> json) => ExpensesModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        transaction: TransactionsModel.fromJson(json["transaction"]),
        user: UsersModel.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "transaction": transaction.toJson(),
        "user": user.toJson(),
      };
}
