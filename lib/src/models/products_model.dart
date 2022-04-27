// To parse this JSON data, do
//
//     final productsModel = productsModelFromJson(jsonString);

import 'dart:convert';

ProductsModel productsModelFromJson(String str) => ProductsModel.fromJson(json.decode(str));

String productsModelToJson(ProductsModel data) => json.encode(data.toJson());

class ProductsModel {
  ProductsModel({
    required this.id,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.images,
  });

  int id;
  String name;
  String description;
  DateTime createdAt;
  DateTime updatedAt;
  List<ImagesModel> images;

  factory ProductsModel.fromJson(Map<String, dynamic> json) => ProductsModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        images: List<ImagesModel>.from(json["images"].map((x) => ImagesModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
      };
}

class ImagesModel {
  ImagesModel({
    required this.id,
    required this.url,
    required this.createdAt,
    required this.updatedAt,
    required this.productId,
  });

  int id;
  String url;
  DateTime createdAt;
  DateTime updatedAt;
  int productId;

  factory ImagesModel.fromJson(Map<String, dynamic> json) => ImagesModel(
        id: json["id"],
        url: json["url"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        productId: json["productId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "productId": productId,
      };
}
