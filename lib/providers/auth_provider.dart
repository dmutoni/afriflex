import 'package:afriflex/api/auth_api.dart';
import 'package:afriflex/models/dto/auth_dto.dart';
import 'package:afriflex/models/state/auth_state_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Auth StateNotifier
class AuthStateNotifier extends StateNotifier<AuthState> {
  AuthStateNotifier() : super(AuthState());

  Future<void> signIn(SignInReqBodyDto dto) async {
    final response = await signin(dto);
    state = state.copyWith(
      useEmail: response.email,
      otpIntent: OTPIntent.signIn,
    );
  }

  Future<void> signUp(SignUpReqBodyDto dto) async {
    final response = await signup(dto);
    state = state.copyWith(
      useEmail: response.data?.emailAddress,
      user: response.data,
      otpIntent: OTPIntent.accountActivation,
    );
  }

  Future<void> fetchCurrentUser() async {
    if(state.accessToken == null) {
      throw Exception('User is not authenticated');
    }
    final response = await getCurrentUser(state.accessToken!);
    state = state.copyWith(
      useEmail: response.data?.emailAddress,
      user: response.data,
    );
  }


  Future<void> verifyOTP(String login, String otp) async {
    switch (state.otpIntent) {
      case OTPIntent.signIn:
        final response = await verifySigninOTP(VerifySigninOTPReqBodyDto(email: login, otp: otp));
        state = state.copyWith(
          accessToken: response.accessToken,
          tokenType: response.tokenType,
          refreshToken: response.refreshToken,
        );
        await fetchCurrentUser();
        break;
      case OTPIntent.accountActivation:
        await activateAccount(ActivateAccountReqBodyDto(emailAddress: login, code: otp));
        break;
      default:
        throw Exception('Invalid OTP intent');
    }
    if(state.accessToken == null || state.accessToken!.isEmpty) {
      signOut();
    }
  }

  bool isLoggedIn() {
    return state.accessToken != null && state.accessToken!.isNotEmpty;
  }

  bool isUserLoaded() {
    return state.user != null;
  }

  void signOut() {
    state = AuthState();
  }
}

// Global provider
final authProvider = StateNotifierProvider<AuthStateNotifier, AuthState>((ref) {
  return AuthStateNotifier();
});