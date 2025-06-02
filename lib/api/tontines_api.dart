import 'dart:convert';

import 'package:afriflex/api/constants.dart';
import 'package:afriflex/models/dto/common_dto.dart';
import 'package:afriflex/models/dto/tontines_dto.dart';
import 'package:afriflex/models/enums/tontine_enum.dart';
import 'package:afriflex/models/tontine_model.dart';
import 'package:http/http.dart' as http;

Future<Page<Tontine>> getUserTontines({
  int page = 1,
  int limit = 10,
  ETontineStatus? status,
  required String accessToken,
}) async {
  final queryParameters = <String, dynamic> {
    'page': page.toString(),
    'limit': limit.toString(),
    if (status != null) 'status': status.name,
  };

  final response = await http.get(
    buildApiUri(endpoint: "/tontines", queryParameters: queryParameters),
    headers: {
      ...jsonContentHeader,
      'Authorization': 'Bearer $accessToken',
    },
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> json = jsonDecode(response.body);
    return Page<Tontine>.fromJson(json, (data) => Tontine.fromJson(data as Map<String, dynamic>));
  } else {
    throw Exception('Failed to load tontines');
  }
}

Future<Tontine> createTontine(CreateTontineDto dto, String accessToken) async {
  final response = await http.post(
    buildApiUri(endpoint: "/tontines"),
    headers: {
      ...jsonContentHeader,
      'Authorization': 'Bearer $accessToken',
    },
    body: jsonEncode(dto.toJson()),
  );
  if (response.statusCode == 200) {
    return Tontine.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to create tontine');
  }
}