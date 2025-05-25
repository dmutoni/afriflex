
import 'package:afriflex/models/user_model.dart';

enum OTPIntent {
  signIn,
  accountActivation,
}

class AuthState {
  User? user;
  String? useEmail;
  String? accessToken;
  String? tokenType;
  String? refreshToken;
  OTPIntent? otpIntent;

  AuthState({
    this.user,
    this.useEmail,
    this.accessToken,
    this.tokenType,
    this.refreshToken,
    this.otpIntent,  
  });

  AuthState copyWith({
    User? user,
    String? useEmail,
    String? accessToken,
    String? tokenType,
    String? refreshToken,
    OTPIntent? otpIntent,
  }) {
    return AuthState(
      user: user ?? this.user,
      useEmail: useEmail ?? this.useEmail,
      accessToken: accessToken ?? this.accessToken,
      tokenType: tokenType ?? this.tokenType,
      refreshToken: refreshToken ?? this.refreshToken,
      otpIntent: otpIntent ?? this.otpIntent,
    );
  }
}