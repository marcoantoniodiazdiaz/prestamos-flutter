class PhonesModel {
  PhonesModel({
    required this.id,
    required this.value,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String value;
  int type;
  DateTime createdAt;
  DateTime updatedAt;

  factory PhonesModel.fromJson(Map<String, dynamic> json) => PhonesModel(
        id: json["id"],
        value: json["value"],
        type: json["type"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "value": value,
        "type": type,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
