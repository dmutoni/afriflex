import 'dart:convert';
import 'package:afriflex/api/constants.dart';
import 'package:afriflex/models/dto/auth_dto.dart';
import 'package:http/http.dart' as http;

Future<SignInResBodyDto> signin(SignInReqBodyDto dto) async {
  final response = await http.post(
    Uri.parse('$baseUrl/auth/signin/initiate'),
    headers: jsonContentHeader,
    body: jsonEncode(dto.toJson()),
  );
  if (response.statusCode == 200) {
    return SignInResBodyDto.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Invalid credentials');
  }
}

Future<UserResBodyDto> signup(SignUpReqBodyDto dto) async {
  final response = await http.post(
    Uri.parse('$baseUrl/auth/signup'),
    headers: jsonContentHeader,
    body: jsonEncode(dto.toJson()),
  );

  if (response.statusCode == 200) {
    return UserResBodyDto.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Invalid input');
  }
}

Future<UserResBodyDto> getCurrentUser(String accessToken) async {
  final response = await http.get(
    Uri.parse('$baseUrl/auth/currentUser'),
    headers: {
      ...jsonContentHeader,
      'Authorization': 'Bearer $accessToken',
    },
  );

  if (response.statusCode == 200) {
    return UserResBodyDto.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to fetch user data');
  }
}


Future<VerifySignInOTPResBodyDto> verifySigninOTP(VerifySigninOTPReqBodyDto dto) async {
  final response = await http.post(
    Uri.parse('$baseUrl/auth/signin/verify'),
    headers: jsonContentHeader,
    body: jsonEncode(dto.toJson()),
  );
  
  if (response.statusCode == 200) {
    return VerifySignInOTPResBodyDto.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to verify OTP');
  }
}

Future<void> activateAccount(ActivateAccountReqBodyDto dto) async {
  final response = await http.post(
    Uri.parse('$baseUrl/auth/activateAccount'),
    headers: jsonContentHeader,
    body: jsonEncode(dto.toJson()),
  );

  if (response.statusCode != 200) {
    throw Exception('Failed to activate account');
  }
}