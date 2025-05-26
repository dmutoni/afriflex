import 'package:afriflex/models/account_model.dart';
import 'package:afriflex/models/dto/common_dto.dart';
import 'package:afriflex/models/enums/transaction_enum.dart';

class Transaction extends Serializable {
  final String id;
  final double amount;
  final String currencyCode;
  final ETransactionType transactionType;
  final ETransactionStatus status;
  final ETransactionCategory category;
  final String description;
  final String referenceNumber;
  final DateTime createdAt;
  final Account senderAccount;
  final Account receiverAccount;
  
  Transaction({
    required this.id,
    required this.transactionType,
    required this.description,
    required this.amount,
    required this.currencyCode,
    required this.createdAt,
    required this.status,
    required this.category,
    required this.referenceNumber,
    required this.senderAccount,
    required this.receiverAccount,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'] as String,
      transactionType: ETransactionType.values.firstWhere((e) => e.name == json['transactionType'] as String),
      description: json['description'] as String,
      amount: (json['amount'] as num).toDouble(),
      currencyCode: json['currencyCode'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      status: ETransactionStatus.values.firstWhere((e) => e.name == json['status'] as String),
      category: ETransactionCategory.values.firstWhere((e) => e.name == json['category'] as String),
      referenceNumber: json['referenceNumber'] as String,
      senderAccount: Account.fromJson(json['senderAccount'] as Map<String, dynamic>),
      receiverAccount: Account.fromJson(json['receiverAccount'] as Map<String, dynamic>),
    );
  }

  @override
  Transaction fromJson(Map<String, dynamic> json) {
    return Transaction.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'transactionType': transactionType.name,
      'description': description,
      'amount': amount,
      'currencyCode': currencyCode,
      'createdAt': createdAt.toIso8601String(),
      'status': status.name,
      'category': category.name,
      'referenceNumber': referenceNumber,
      'senderAccount': senderAccount.toJson(),
      'receiverAccount': receiverAccount.toJson(),
    };
  }
}