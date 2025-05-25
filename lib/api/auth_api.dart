import 'dart:convert';

import 'package:afriflex/api/constants.dart';
import 'package:afriflex/models/dto/signin_dto.dart';
import 'package:afriflex/models/dto/signup_dto.dart';
import 'package:http/http.dart' as http;

Future<SignInResBodyDto> signin(SignInReqBodyDto dto) async {
  final response = await http.post(
    Uri.parse('$baseUrl/auth/signin'),
    headers: jsonContentHeader,
    body: jsonEncode(dto.toJson()),
  );
  if (response.statusCode == 200) {
    return SignInResBodyDto.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Invalid credentials');
  }
}

Future<SignUpResBodyDto> signup(SignUpReqBodyDto dto) async {
  final response = await http.post(
    Uri.parse('$baseUrl/auth/signup'),
    headers: jsonContentHeader,
    body: jsonEncode(dto.toJson()),
  );

  if (response.statusCode == 200) {
    return SignUpResBodyDto.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Invalid input');
  }
}