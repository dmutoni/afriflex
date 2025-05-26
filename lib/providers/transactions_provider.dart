import 'package:afriflex/api/transactions_api.dart';
import 'package:afriflex/models/dto/common_dto.dart';
import 'package:afriflex/models/enums/transaction_enum.dart';
import 'package:afriflex/models/transaction_model.dart';
import 'package:afriflex/providers/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final filterTransactionsProvider = FutureProvider.family<Page<Transaction>, ({
  int page,
  int limit,
  ETransactionCategory? category,
  ETransactionType? transactionType,
  ETransactionStatus? status,
  String? accountNumber,
  bool? areIncomingTransactions,
  DateTime? startDate,
  DateTime? endDate,
})>((ref, params) async {
  return await filterTransactions(
    category: params.category,
    transactionType: params.transactionType,
    status: params.status,
    accountNumber: params.accountNumber,
    startDate: params.startDate,
    endDate: params.endDate,
    areIncomingTransactions: params.areIncomingTransactions,
    accessToken: ref.read(authProvider).accessToken ?? '',
    page: params.page,
    limit: params.limit,
  );
});