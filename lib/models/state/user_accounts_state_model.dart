import 'package:afriflex/models/account_model.dart';

class UserAccountsState {
  List<Account> accounts;
  bool isLoading;
  String? error;

  UserAccountsState({
    required this.accounts,
    required this.isLoading,
    this.error,
  });

  UserAccountsState copyWith({
    bool? isLoading,
    List<Account>? accounts,
    String? error,
  }) {
    return UserAccountsState(
      accounts: accounts ?? this.accounts,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}