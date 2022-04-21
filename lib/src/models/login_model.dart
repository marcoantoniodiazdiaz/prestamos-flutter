import 'dart:convert';

import 'package:prestamos/src/database/database.dart';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    required this.user,
    required this.token,
  });

  UsersModel user;
  String token;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        user: UsersModel.fromJson(json["user"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "token": token,
      };
}
