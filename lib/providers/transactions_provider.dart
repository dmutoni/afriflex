import 'package:afriflex/api/transactions_api.dart';
import 'package:afriflex/models/dto/common_dto.dart';
import 'package:afriflex/models/transaction_model.dart';
import 'package:afriflex/providers/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeIncomingTransactionsProvider = FutureProvider.family<Page<Transaction>, ({
  String? accountNumber
})>((ref, params) async {
  return await filterTransactions(
    accountNumber: params.accountNumber,
    areIncomingTransactions: true,
    accessToken: ref.read(authProvider).accessToken ?? '',
    page: 1,
    limit: 5,
  );
});

final homeOutgoingTransactionsProvider = FutureProvider.family<Page<Transaction>, ({
  String accountNumber
})>((ref, params) async {
  return await filterTransactions(
    accountNumber: params.accountNumber,
    areIncomingTransactions: false,
    accessToken: ref.read(authProvider).accessToken ?? '',
    page: 1,
    limit: 5,
  );
});