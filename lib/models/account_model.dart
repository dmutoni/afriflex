import 'package:afriflex/models/dto/common_dto.dart';
import 'package:afriflex/models/user_model.dart';

class Account extends Serializable {
  final String id;
  final String accountType;
  final double balance;
  final String currencyCode;
  final String accountNumber;
  final String? accountName;
  final User? user;
  final DateTime createdAt;

  Account({
    required this.id,
    required this.accountType,
    required this.balance,
    required this.currencyCode,
    required this.accountNumber,
    required this.createdAt,
    this.user,
    this.accountName,
  });

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      id: json['id'],
      accountType: json['accountType'],
      balance: (json['balance'] as num).toDouble(),
      currencyCode: json['currencyCode'] ?? (json['currency'] ?? ''),
      accountNumber: json['accountNumber'],
      createdAt: DateTime.parse(json['createdAt']),
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      accountName: json['accountName'] as String?,
    );
  }

  @override
  Account fromJson(Map<String, dynamic> json) {
    return Account.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'accountType': accountType,
      'balance': balance,
      'currencyCode': currencyCode,
      'accountNumber': accountNumber,
      'createdAt': createdAt.toIso8601String(),
      'user': user?.toJson(),
      'accountName': accountName,
    };
  }
}