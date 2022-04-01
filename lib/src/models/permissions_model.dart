import 'dart:convert';

import 'package:prestamos/src/models/users_model.dart';

PermissionsModel permissionsModelFromJson(String str) => PermissionsModel.fromJson(json.decode(str));

String permissionsModelToJson(PermissionsModel data) => json.encode(data.toJson());

class PermissionsModel {
  PermissionsModel({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.action,
    required this.user,
  });

  int id;
  DateTime createdAt;
  DateTime updatedAt;
  ActionsModel action;
  UsersModel user;

  factory PermissionsModel.fromJson(Map<String, dynamic> json) => PermissionsModel(
        id: json["id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        action: ActionsModel.fromJson(json["action"]),
        user: UsersModel.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "action": action.toJson(),
        "user": user.toJson(),
      };
}

class ActionsModel {
  ActionsModel({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String name;
  DateTime createdAt;
  DateTime updatedAt;

  factory ActionsModel.fromJson(Map<String, dynamic> json) => ActionsModel(
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
