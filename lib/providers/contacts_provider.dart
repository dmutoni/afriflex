
import 'package:afriflex/api/contacts_api.dart';
import 'package:afriflex/models/contact_model.dart';
import 'package:afriflex/providers/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userContactsProvider = FutureProvider.family<List<Contact>, ()>((ref, params) async {
  return await getUserContacts(ref.read(authProvider).accessToken ?? '');
});