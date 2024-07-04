// To parse this JSON data, do
//
//     final serviceResModel = serviceResModelFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

ServiceResModel serviceResModelFromJson(String str) =>
    ServiceResModel.fromJson(json.decode(str));

String serviceResModelToJson(ServiceResModel data) =>
    json.encode(data.toJson());

class ServiceResModel {
  String? did;
  String? serviceName;
  DateTime? createdAt;
  String? image;

  ServiceResModel({
    required this.did,
    required this.serviceName,
    required this.image,
    required this.createdAt,
  });

  factory ServiceResModel.fromJson(Map<String, dynamic> json) =>
      ServiceResModel(
        did: json["Did"] ?? "",
        serviceName: json["ServiceName"] ?? "",
        image: json["image"] ?? "",
        createdAt: (json['createdAt'] as Timestamp).toDate() ?? DateTime.now(),
      );

  Map<String, dynamic> toJson() => {
        'createdAt': Timestamp.fromDate(createdAt ?? DateTime.now()),
        "Did": did ?? "",
        "ServiceName": serviceName ?? "",
        "image": image ?? "",
      };
}
