import 'package:afriflex/api/accounts_api.dart';
import 'package:afriflex/models/account_model.dart';
import 'package:afriflex/providers/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userAccountsProvider = FutureProvider.family<List<Account>, ()>((ref, params) async {
  return await getUserAccounts(ref.read(authProvider).accessToken ?? '');
});