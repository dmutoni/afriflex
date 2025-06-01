import 'package:afriflex/api/accounts_api.dart';
import 'package:afriflex/models/state/auth_state_model.dart';
import 'package:afriflex/models/state/user_accounts_state_model.dart';
import 'package:afriflex/providers/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserAccountsStateNotifier extends StateNotifier<UserAccountsState> {
  final Ref ref;

  UserAccountsStateNotifier(this.ref) : super(UserAccountsState(accounts: [], isLoading: false, error: null)) {
    ref.listen<AuthState>(authProvider, (previous, next) {
      if (next.accessToken != null) {
        fetchUserAccounts();
      } else {
        state = state.copyWith(accounts: [], isLoading: false, error: 'Unauthorized');
      }
    });
    
    fetchUserAccounts();
  }

  Future<void> fetchUserAccounts() async {
    final accessToken = ref.read(authProvider).accessToken;
    
    // Check if the user is authenticated
    if (accessToken == null) {
      state = state.copyWith(isLoading: false, error: 'Unauthorized');
      return;
    }

    state = state.copyWith(isLoading: true, error: null);
    try {
      final accounts = await getUserAccounts(accessToken);
      state = state.copyWith(accounts: accounts, isLoading: false, error: null);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: 'Failed to fetch accounts');
    }
  }
}

final userAccountsProvider = StateNotifierProvider<UserAccountsStateNotifier, UserAccountsState>((ref) {
  return UserAccountsStateNotifier(ref);
});