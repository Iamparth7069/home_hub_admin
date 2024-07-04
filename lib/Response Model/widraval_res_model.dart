import 'package:cloud_firestore/cloud_firestore.dart';

class WithdrawalResModel {
  final String providerId;
  final double amountWithdraw;
  final DateTime date;
  final String type;
  final String uipIndia;
  final String id;

  WithdrawalResModel({
    required this.providerId,
    required this.amountWithdraw,
    required this.date,
    required this.type,
    required this.uipIndia,
    required this.id,
  });

  factory WithdrawalResModel.fromJson(Map<String, dynamic> json) {
    return WithdrawalResModel(
      providerId: json['ProviderId'] ?? '',
      amountWithdraw: (json['amount'] ?? 0).toDouble(),
      date: json['date']?.toDate() ?? DateTime.now(),
      type: json['type'] ?? '',
      uipIndia: json['uipIndia'] ?? '',
      id: json['id'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ProviderId': providerId,
      'amount': amountWithdraw,
      'date': Timestamp.fromDate(date),
      'type': type,
      'id': id,
      'uipIndia': uipIndia,
    };
  }
}
