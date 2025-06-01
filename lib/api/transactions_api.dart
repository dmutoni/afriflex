import 'dart:convert';

import 'package:afriflex/api/constants.dart';
import 'package:afriflex/models/dto/common_dto.dart';
import 'package:afriflex/models/enums/transaction_enum.dart';
import 'package:afriflex/models/transaction_model.dart';
import 'package:http/http.dart' as http;

Future<Page<Transaction>> filterTransactions({
  required String accessToken,
  required int page,
  required int limit,
  ETransactionCategory? category,
  ETransactionType? transactionType,
  ETransactionStatus? status,
  bool? areIncomingTransactions,
  String? accountNumber,
  String? userId,
  DateTime? startDate,
  DateTime? endDate,
}) async {
  final queryParameters = <String, dynamic> {
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

  // print('===================HERE3===================');
  // print('Response status: ${response.statusCode}');
  // print('Response body: ${response.body}');
  // print('ResBody JSON : ${jsonDecode(response.body)}');
  // print('Resbody Data JSON: ${jsonDecode(response.body)['data']}');
  // print('===================HERE3===================');

  if (response.statusCode == 200) {
    return Page<Transaction>.fromJson(
      jsonDecode(response.body)['data'] as Map<String, dynamic>,
      (json) => Transaction.fromJson(json as Map<String, dynamic>),
    );
  } else {
    throw Exception('Failed to filter transactions');
  }
}