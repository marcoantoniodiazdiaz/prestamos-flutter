import 'dart:convert';

PermissionsModel permissionsModelFromJson(String str) => PermissionsModel.fromJson(json.decode(str));

String permissionsModelToJson(PermissionsModel data) => json.encode(data.toJson());

class PermissionsModel {
  PermissionsModel({
    required this.action,
    required this.has,
  });

  ActionsModel action;
  bool has;

  factory PermissionsModel.fromJson(Map<String, dynamic> json) => PermissionsModel(
        action: ActionsModel.fromJson(json["action"]),
        has: json["has"],
      );

  Map<String, dynamic> toJson() => {
        "action": action.toJson(),
        "has": has,
      };
}

class ActionsModel {
  ActionsModel({
    required this.id,
    required this.name,
    required this.code,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String name;
  int code;
  DateTime createdAt;
  DateTime updatedAt;

  factory ActionsModel.fromJson(Map<String, dynamic> json) => ActionsModel(
        id: json["id"],
        name: json["name"],
        code: json["code"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "code": code,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
