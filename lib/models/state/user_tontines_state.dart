import 'package:afriflex/models/tontine_model.dart';

class UserTontinesState {
  final List<Tontine> tontines;
  final bool isLoading;
  final String? error;

  UserTontinesState({
    required this.tontines,
    this.isLoading = false,
    this.error,
  });

  UserTontinesState copyWith({
    List<Tontine>? tontines,
    bool? isLoading,
    String? error,
  }) {
    return UserTontinesState(
      tontines: tontines ?? this.tontines,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}