// To parse this JSON data, do
//
//     final loansModel = loansModelFromJson(jsonString);
import 'dart:convert';

import 'package:prestamos/src/models/clients_model.dart';
import 'package:prestamos/src/models/payments_model.dart';

LoansModel loansModelFromJson(String str) => LoansModel.fromJson(json.decode(str));

String loansModelToJson(LoansModel data) => json.encode(data.toJson());

class LoansModel {
  LoansModel({
    required this.id,
    required this.concurrency,
    required this.amount,
    required this.duration,
    required this.fee,
    required this.interest,
    required this.createdAt,
    required this.updatedAt,
    required this.client,
    required this.payments,
  });

  int id;
  int concurrency;
  double amount;
  int duration;
  double fee;
  double interest;
  DateTime createdAt;
  DateTime updatedAt;
  ClientsModel client;
  List<PaymentsModel> payments;

  factory LoansModel.fromJson(Map<String, dynamic> json) => LoansModel(
        id: json["id"],
        concurrency: json["concurrency"],
        amount: json["amount"].toDouble(),
        duration: json["duration"],
        fee: json["fee"].toDouble(),
        interest: json["interest"].toDouble(),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        client: ClientsModel.fromJson(json["client"]),
        payments: List<PaymentsModel>.from(json["payments"].map((x) => PaymentsModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "concurrency": concurrency,
        "amount": amount,
        "duration": duration,
        "fee": fee,
        "interest": interest,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "client": client.toJson(),
        "payments": List<dynamic>.from(payments.map((x) => x.toJson())),
      };
}
