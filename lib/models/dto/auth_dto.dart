import 'package:afriflex/models/dto/common_dto.dart';
import 'package:afriflex/models/user_model.dart';

class SignInReqBodyDto {
  String login;
  String password;

  SignInReqBodyDto({
    required this.login,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'login': login,
      'password': password,
    };
  }
}

class SignInResBodyDto {
  String message;
  String email;

  SignInResBodyDto({
    required this.message,
    required this.email,
  });

  factory SignInResBodyDto.fromJson(Map<String, dynamic> json) {
    return SignInResBodyDto(
      message: json['data']['message'],
      email: json['data']['email'],
    );
  }
}

class VerifySignInOTPResBodyDto {
  String message;
  String accessToken;
  String tokenType;
  String? refreshToken;

  VerifySignInOTPResBodyDto({
    required this.message,
    required this.accessToken,
    required this.tokenType,
    this.refreshToken,
  });

  factory VerifySignInOTPResBodyDto.fromJson(Map<String, dynamic> json) {
    return VerifySignInOTPResBodyDto(
      message: json['message'],
      accessToken: json['data']['token']['accessToken'],
      tokenType: json['data']['token']['tokenType'],
      refreshToken: json['data']['token']['refreshToken'],
    );
  }
}

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

class UserResBodyDto extends ResBody<User> {
  UserResBodyDto({
    required super.data,
    required super.message,
    required super.status,
    required super.timestamp,
  });

  @override
  factory UserResBodyDto.fromJson(Map<String, dynamic> json) {
    return UserResBodyDto(
      data: User.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String?,
      status: json['status'] as String?,
      timestamp: json['timestamp'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data?.toJson(),
      'message': message,
      'status': status,
      'timestamp': timestamp,
    };
  }
}

class VerifySigninOTPReqBodyDto {
  String email;
  String otp;

  VerifySigninOTPReqBodyDto({
    required this.email,
    required this.otp,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'otp': otp,
    };
  }
}

class ActivateAccountReqBodyDto {
  String emailAddress;
  String code;

  ActivateAccountReqBodyDto({
    required this.emailAddress,
    required this.code,
  });

  Map<String, dynamic> toJson() {
    return {
      'emailAddress': emailAddress,
      'code': code,
    };
  }
}