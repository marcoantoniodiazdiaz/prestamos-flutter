class UsersModel {
  UsersModel({
    required this.id,
    required this.name,
    required this.email,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String name;
  String email;
  String image;
  DateTime createdAt;
  DateTime updatedAt;

  factory UsersModel.fromJson(Map<String, dynamic> json) => UsersModel(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        image: json["image"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "image": image,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
