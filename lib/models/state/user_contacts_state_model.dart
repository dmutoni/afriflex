import 'package:afriflex/models/contact_model.dart';

class UserContactsState {
  final List<Contact> contacts;
  final bool isLoading;
  final String? error;

  UserContactsState({
    required this.contacts,
    required this.isLoading,
    this.error,
  });

  UserContactsState copyWith({
    List<Contact>? contacts,
    bool? isLoading,
    String? error,
  }) {
    return UserContactsState(
      contacts: contacts ?? this.contacts,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}