class DirectionsModel {
  DirectionsModel({
    required this.id,
    required this.street,
    required this.suburb,
    required this.city,
    required this.latitude,
    required this.longitude,
    required this.directionsModelDefault,
    required this.createdAt,
    required this.updatedAt,
    required this.clientId,
  });

  int id;
  String street;
  String suburb;
  String city;
  double latitude;
  double longitude;
  bool directionsModelDefault;
  DateTime createdAt;
  DateTime updatedAt;
  int clientId;

  factory DirectionsModel.fromJson(Map<String, dynamic> json) => DirectionsModel(
        id: json["id"],
        street: json["street"],
        suburb: json["suburb"],
        city: json["city"],
        latitude: json["latitude"].toDouble(),
        longitude: json["longitude"].toDouble(),
        directionsModelDefault: json["default"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        clientId: json["clientId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "street": street,
        "suburb": suburb,
        "city": city,
        "latitude": latitude,
        "longitude": longitude,
        "default": directionsModelDefault,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "clientId": clientId,
      };
}
