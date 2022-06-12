import 'dart:convert';

import 'package:prestamos/src/models/phones_model.dart';

ClientsModel clientsModelFromJson(String str) => ClientsModel.fromJson(json.decode(str));

String clientsModelToJson(ClientsModel data) => json.encode(data.toJson());

class ClientsModel {
  ClientsModel({
    required this.id,
    required this.name,
    required this.direction,
    required this.city,
    required this.email,
    required this.comment,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
    required this.phones,
  });

  int id;
  String name;
  String direction;
  String city;
  String email;
  String? comment;
  String image;
  DateTime createdAt;
  DateTime updatedAt;
  List<PhonesModel> phones;

  factory ClientsModel.fromJson(Map<String, dynamic> json) => ClientsModel(
        id: json["id"],
        name: json["name"],
        direction: json["direction"],
        city: json["city"],
        email: json["email"],
        comment: json["comment"],
        image: json["image"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        phones: List<PhonesModel>.from(json["phones"].map((x) => PhonesModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "direction": direction,
        "city": city,
        "email": email,
        "comment": comment,
        "image": image,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "phones": List<dynamic>.from(phones.map((x) => x.toJson())),
      };
}
