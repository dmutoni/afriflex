import 'package:afriflex/models/account_model.dart';
import 'package:afriflex/models/user_model.dart';

class Contact {
  final String id;
  final String contactName;
  final String phoneNumber;
  final User user;
  final Account account;
  final DateTime createdAt;

  Contact({
    required this.id,
    required this.contactName,
    required this.phoneNumber,
    required this.user,
    required this.account,
    required this.createdAt,
  });

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      id: json['id'] as String,
      contactName: json['contactName'] as String,
      phoneNumber: json['phoneNumber'] as String,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      account: Account.fromJson(json['account'] as Map<String, dynamic>),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }
}