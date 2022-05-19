class SettingsModel {
  SettingsModel({
    required this.id,
    required this.key,
    required this.value,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final String key;
  final String value;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory SettingsModel.fromJson(Map<String, dynamic> json) => SettingsModel(
        id: json["id"],
        key: json["key"],
        value: json["value"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "key": key,
        "value": value,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
