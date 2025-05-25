import 'package:afriflex/api/auth_api.dart';
import 'package:afriflex/models/dto/signin_dto.dart';
import 'package:afriflex/models/dto/signup_dto.dart';
import 'package:afriflex/models/state/auth_state_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Auth StateNotifier
class AuthStateNotifier extends StateNotifier<AuthState> {
  AuthStateNotifier() : super(AuthState());

  Future<void> signIn(SignInReqBodyDto dto) async {
    final response = await signin(dto);
    state = state.copyWith(
      accessToken: response.accessToken,
      tokenType: response.tokenType,
      refreshToken: response.refreshToken,
    );
  }

  Future<void> signUp(SignUpReqBodyDto dto) async {
    final response = await signup(dto);
    state = state.copyWith(
      user: response.data,
    );
  }

  void signOut() {
    state = AuthState();
  }
}

// Global provider
final authProvider = StateNotifierProvider<AuthStateNotifier, AuthState>((ref) {
  return AuthStateNotifier();
});