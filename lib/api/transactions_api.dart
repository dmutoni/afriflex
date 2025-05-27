import 'dart:convert';

import 'package:afriflex/api/constants.dart';
import 'package:afriflex/models/dto/common_dto.dart';
import 'package:afriflex/models/enums/transaction_enum.dart';
import 'package:afriflex/models/transaction_model.dart';
import 'package:http/http.dart' as http;

Future<Page<Transaction>> filterTransactions({
  required ETransactionCategory? category,
  required ETransactionType? transactionType,
  required ETransactionStatus? status,
  bool? areIncomingTransactions,
  String? accountNumber,
  String? userId,
  DateTime? startDate,
  DateTime? endDate,
  required String accessToken,
  required int page,
  required int limit,
}) async {
  final queryParameters = <String, String>{
    'page': page.toString(),
    'limit': limit.toString(),
    if (category != null) 'category': category.name,
    if (transactionType != null) 'transactionType': transactionType.name,
    if (status != null) 'status': status.name,
    if (accountNumber != null && accountNumber.isNotEmpty) 'accountNumber': accountNumber,
    if (areIncomingTransactions != null) 'areIncomingTransactions': areIncomingTransactions.toString(),
    if (startDate != null) 'startDate': startDate.toIso8601String(),
    if (endDate != null) 'endDate': endDate.toIso8601String(),
  };

  final response = await http.get(
    buildApiUri(endpoint: '/transactions/filter', queryParameters: queryParameters),
    headers: {
      ...jsonContentHeader,
      'Authorization': 'Bearer $accessToken',
    },
  );

  if (response.statusCode == 200) {
    return Page<Transaction>.fromJson(
      jsonDecode(response.body)['data'] as Map<String, dynamic>,
      (json) => Transaction.fromJson(json as Map<String, dynamic>),
    );
  } else {
    throw Exception('Failed to filter transactions');
  }
}