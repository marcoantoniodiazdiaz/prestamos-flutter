// To parse this JSON data, do
//
//     final pawnsModel = pawnsModelFromJson(jsonString);

import 'dart:convert';

import 'package:prestamos/src/models/loans_model.dart';
import 'package:prestamos/src/models/products_model.dart';

PawnsModel pawnsModelFromJson(String str) => PawnsModel.fromJson(json.decode(str));

String pawnsModelToJson(PawnsModel data) => json.encode(data.toJson());

class PawnsModel {
  PawnsModel({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.loan,
    required this.product,
  });

  int id;
  DateTime createdAt;
  DateTime updatedAt;
  LoansModel loan;
  ProductsModel product;

  factory PawnsModel.fromJson(Map<String, dynamic> json) => PawnsModel(
        id: json["id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        loan: LoansModel.fromJson(json["loan"]),
        product: ProductsModel.fromJson(json["product"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "loan": loan.toJson(),
        "product": product.toJson(),
      };
}
