import 'package:flutter_riverpod/flutter_riverpod.dart';

class AmountNotifier extends StateNotifier<String> {
  AmountNotifier() : super('');

  void updateAmount(String newAmount) {
    state = newAmount;
  }

  void clearAmount() {
    state = '';
  }
}

final amountNotifierProvider = StateNotifierProvider<AmountNotifier, String>(
  (ref) => AmountNotifier(),
);
