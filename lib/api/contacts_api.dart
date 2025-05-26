
import 'dart:convert';

import 'package:afriflex/api/constants.dart';
import 'package:afriflex/models/contact_model.dart';
import 'package:http/http.dart' as http;

Future<List<Contact>> getUserContacts(String accessToken) async {
  final response = await http.get(
    Uri.parse('$baseUrl/contacts'),
    headers: {
      ...jsonContentHeader,
      'Authorization': 'Bearer $accessToken',
    },
  );
  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body)['data'] as List<dynamic>;
    return data.map((item) => Contact.fromJson(item)).toList();
  } else {
    throw Exception('Failed to fetch contacts');
  }
}