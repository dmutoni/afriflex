
import 'package:afriflex/api/tontines_api.dart';
import 'package:afriflex/models/dto/common_dto.dart';
import 'package:afriflex/models/enums/tontine_enum.dart';
import 'package:afriflex/models/tontine_model.dart';
import 'package:afriflex/providers/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final activeTontinesProvider = FutureProvider.family<Page<Tontine>, ()>((ref, params) async {
  return await getUserTontines(
    page: 1,
    limit: 5,
    status: ETontineStatus.active,
    accessToken: ref.read(authProvider).accessToken ?? '',
  );
});