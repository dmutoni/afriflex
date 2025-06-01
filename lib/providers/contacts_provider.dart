
import 'package:afriflex/api/contacts_api.dart';
import 'package:afriflex/models/state/auth_state_model.dart';
import 'package:afriflex/models/state/user_contacts_state_model.dart';
import 'package:afriflex/providers/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserContactsStateNotifier extends StateNotifier<UserContactsState> {
  final Ref ref;

  UserContactsStateNotifier(this.ref) : super(UserContactsState(contacts: [], isLoading: false, error: null)) {
    ref.listen<AuthState>(authProvider, (previous, next) {
      if (next.accessToken != null) {
        fetchUserContacts();
      } else {
        state = state.copyWith(contacts: [], isLoading: false, error: 'Unauthorized');
      }
    });

    fetchUserContacts();
  }

  Future<void> fetchUserContacts() async {
    final accessToken = ref.read(authProvider).accessToken;
    
    // Check if the user is authenticated
    if (accessToken == null) {
      state = state.copyWith(isLoading: false, error: 'Unauthorized');
      return;
    }

    state = state.copyWith(isLoading: true, error: null);
    try {
      final contacts = await getUserContacts(accessToken);
      state = state.copyWith(contacts: contacts, isLoading: false, error: null);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: 'Failed to fetch contacts');
    }
  }
}

final userContactsProvider = StateNotifierProvider<UserContactsStateNotifier, UserContactsState>((ref) {
  return UserContactsStateNotifier(ref);
});