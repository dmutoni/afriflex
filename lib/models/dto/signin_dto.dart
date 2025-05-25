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
  String accessToken;
  String tokenType;
  String? refreshToken;

  SignInResBodyDto({
    required this.accessToken,
    required this.tokenType,
    this.refreshToken,
  });

  factory SignInResBodyDto.fromJson(Map<String, dynamic> json) {
    return SignInResBodyDto(
      accessToken: json['token']['accessToken'],
      tokenType: json['token']['tokenType'],
      refreshToken: json['token']['refreshToken'],
    );
  }
}