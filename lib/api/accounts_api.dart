import 'dart:convert';

import 'package:afriflex/api/constants.dart';
import 'package:afriflex/models/account_model.dart';
import 'package:http/http.dart' as http;

Future<List<Account>> getUserAccounts(String accessToken) async {
  final response = await http.get(
    Uri.parse('$baseUrl/client-accounts/mine'),
    headers: {
      ...jsonContentHeader,
      'Authorization': 'Bearer $accessToken',
    },
  );

  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body)['data'] as List<dynamic>;
    return data.map((item) => Account.fromJson(item)).toList();
  } else {
    throw Exception('Failed to fetch accounts');
  }
}