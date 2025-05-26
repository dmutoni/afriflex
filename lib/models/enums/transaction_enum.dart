enum ETransactionStatus {
  pending('PENDING'),
  completed('COMPLETED'),
  failed('FAILED');
  
  final String name;

  const ETransactionStatus(this.name);
}

enum ETransactionType {
  deposit('DEPOSIT'),
  withdrawal('WITHDRAWAL'),
  transfer('TRANSFER');

  final String name;

  const ETransactionType(this.name);
}

enum ETransactionCategory {
  afriflexWallet('AFRIFLEX_WALLET'),
  orangeMoney('ORANGE_MONEY'),
  momo('MOMO'),
  airtelMoney('AIRTEL_MONEY');
  
  final String name;

  const ETransactionCategory(this.name);
}