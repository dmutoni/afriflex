import 'package:afriflex/enums/widget_configurations/app_button_variant.dart';
import 'package:afriflex/values/colors.dart';
import 'package:afriflex/values/dimens.dart';
import 'package:afriflex/widgets/common/input/afriflex_button.dart';
import 'package:afriflex/widgets/templates/generic_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectFromContactsScreen extends ConsumerStatefulWidget {
  const SelectFromContactsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SelectFromContactsScreenState();
}

class _SelectFromContactsScreenState
    extends ConsumerState<SelectFromContactsScreen> {
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
    return GenericTemplate(
      isScrollable: true,
      title: 'Invite members',
      content: Container(
        padding: const EdgeInsets.all(Dimens.marginDefault),
        child: Column(
          spacing: 10,
          children: [
            contactsWidget(),
            AfriflexButton(
              title: 'Continue',
              onTap: () {},
            ),
            Row(
              spacing: 14,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2.5,
                  child: const Divider(
                    color: ThemeColors.grayLight,
                  ),
                ),
                const Text('OR'),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2.5,
                  child: const Divider(
                    color: ThemeColors.grayLight,
                  ),
                ),
              ],
            ),
            AfriflexButton(
              variant: AfriflexButtonVariant.clear,
              title: 'Input AfriflexPay\'s username',
              onTap: () {},
            ),
          ],
        ),
      ),
      backgroundColor: ThemeColors.whiteColor,
    );
  }

  Widget contactsWidget() {
    return FutureBuilder<List<Contact>>(
      future: _getContacts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError || _permissionDenied) {
          return const Center(
              child: Text('Permission denied or error occurred'));
        }
        final List<Contact>? contacts = snapshot.data;

        return ListView.builder(
          shrinkWrap: true,
          itemCount: contacts?.length ?? 0,
          itemBuilder: (context, i) => _buildContactWidget(
            contact: contacts![i],
          ),
        );
      },
    );
  }

  Future<List<Contact>> _getContacts() async {
    if (!await FlutterContacts.requestPermission(readonly: true)) {
      setState(() => _permissionDenied = true);
      return [];
    }
    return FlutterContacts.getContacts();
  }

  Widget _buildContactWidget({
    required Contact contact,
  }) {
    String initials = '';
    if (contact.displayName.isNotEmpty) {
      List<String> nameParts = contact.displayName.split(' ');
      if (nameParts.length > 1) {
        initials = nameParts[0][0] + nameParts[1][0];
      } else {
        initials = nameParts[0][0];
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: Dimens.marginFive,
      ),
      child: Container(
        width: 100,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: ThemeColors.whiteColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          spacing: 10,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Center(
                child: Text(
                  initials.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.sizeOf(context).width - 205,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    contact.name.first != ''
                        ? '${contact.name.first} ' ' ${contact.name.last}'
                        : contact.displayName,
                    style: const TextStyle(
                      fontSize: 16,
                      color: ThemeColors.blackColor,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    contact.phones.isNotEmpty
                        ? contact.phones.first.customLabel
                        : 'No phone number',
                    style: const TextStyle(fontSize: 14),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            AfriflexButton(
              width: 80,
              height: 40,
              title: 'Invite',
              variant: AfriflexButtonVariant.light,
              onTap: () {
                // Handle invite
              },
            ),
          ],
        ),
      ),
    );
  }
}
