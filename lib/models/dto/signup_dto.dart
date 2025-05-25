import 'package:afriflex/models/user_model.dart';

class SignUpReqBodyDto {
  String firstName;
  String lastName;
  String emailAddress;
  String phoneNumber;
  int countryId;
  String password;

  SignUpReqBodyDto({
    required this.firstName,
    required this.lastName,
    required this.emailAddress,
    required this.phoneNumber,
    required this.countryId,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'emailAddress': emailAddress,
      'phoneNumber': phoneNumber,
      'countryId': countryId,
      'password': password,
    };
  }
}

class SignUpResBodyDto {
  User data;
  String message;
  String status;
  
  SignUpResBodyDto({
    required this.data,
    required this.message,
    required this.status,
  });

  factory SignUpResBodyDto.fromJson(Map<String, dynamic> json) {
    return SignUpResBodyDto(
      data: User.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String,
      status: json['status'] as String,
    );
  }
}