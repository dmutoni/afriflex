import 'package:afriflex/values/colors.dart';
import 'package:afriflex/widgets/templates/generic_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PendingRequestScreen extends ConsumerStatefulWidget {
  const PendingRequestScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PendingScreensState();
}

class _PendingScreensState extends ConsumerState<PendingRequestScreen> {
  bool _permissionDenied = false;

  @override
  void initState() {
    super.initState();
    _fetchContacts();
  }

  Future<dynamic> _fetchContacts() async {
    if (!await FlutterContacts.requestPermission(readonly: true)) {
      setState(() => _permissionDenied = true);
    } else {
      await FlutterContacts.getContacts();
    }
  }

  @override
  Widget build(BuildContext context) {
    return const GenericTemplate(
      backgroundColor: ThemeColors.whiteColor,
      title: 'Pending join requests',
      content: SingleChildScrollView(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
