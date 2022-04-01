class ProductsModel {
  ProductsModel({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.image,
  });

  int id;
  String name;
  DateTime createdAt;
  DateTime updatedAt;
  String image;

  factory ProductsModel.fromJson(Map<String, dynamic> json) => ProductsModel(
        id: json["id"],
        name: json["name"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "image": image,
      };
}
