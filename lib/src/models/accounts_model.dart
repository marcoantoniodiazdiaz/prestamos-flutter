// To parse this JSON data, do
//
//     final accountsModel = accountsModelFromJson(jsonString);

import 'dart:convert';

AccountsModel accountsModelFromJson(String str) => AccountsModel.fromJson(json.decode(str));

String accountsModelToJson(AccountsModel data) => json.encode(data.toJson());

class AccountsModel {
  AccountsModel({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory AccountsModel.fromJson(Map<String, dynamic> json) => AccountsModel(
        id: json["id"],
        name: json["name"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
