import 'package:cloud_firestore/cloud_firestore.dart';

class RefundResModel {
  final int amount;
  final DateTime date;
  final String orderId;
  final String type;
  final String id;
  final String userId;

  RefundResModel({
    required this.amount,
    required this.id,
    required this.date,
    required this.orderId,
    required this.type,
    required this.userId,
  });

  factory RefundResModel.fromJson(Map<String, dynamic> json) {
    return RefundResModel(
      amount: json['amount'] ?? 0,
      date: (json['date'] as Timestamp).toDate(),
      orderId: json['orderId'] ?? '',
      id: json['id'] ?? '',
      type: json['type'] ?? '',
      userId: json['userId'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'date': Timestamp.fromDate(date),
      'orderId': orderId,
      'type': type,
      'userId': userId,
    };
  }
}
