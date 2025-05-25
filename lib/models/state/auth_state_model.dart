
import 'package:afriflex/models/user_model.dart';

class AuthState {
  User? user;
  String? accessToken;
  String? tokenType;
  String? refreshToken;

  AuthState({
    this.user,
    this.accessToken,
    this.tokenType,
    this.refreshToken,
  });

  AuthState copyWith({
    User? user,
    String? accessToken,
    String? tokenType,
    String? refreshToken,
  }) {
    return AuthState(
      user: user ?? this.user,
      accessToken: accessToken ?? this.accessToken,
      tokenType: tokenType ?? this.tokenType,
      refreshToken: refreshToken ?? this.refreshToken,
    );
  }
}