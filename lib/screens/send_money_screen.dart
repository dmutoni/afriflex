import 'package:afriflex/enums/route_configurations/afriflex_routes.dart';
import 'package:afriflex/values/colors.dart';
import 'package:afriflex/values/dimens.dart';
import 'package:afriflex/widgets/common/afriflex_dropdown.dart';
import 'package:afriflex/widgets/common/input/afriflex_button.dart';
import 'package:afriflex/widgets/common/input/afriflex_text_input.dart';
import 'package:afriflex/widgets/templates/generic_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SendMoneyScreen extends ConsumerStatefulWidget {
  const SendMoneyScreen({super.key});

  @override
  ConsumerState<SendMoneyScreen> createState() => _SendMoneyScreenState();
}

class _SendMoneyScreenState extends ConsumerState<SendMoneyScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController recipientModeController = TextEditingController();
  final TextEditingController recipientNameController = TextEditingController();

  @override
  void dispose() {
    phoneNumberController.dispose();
    recipientModeController.dispose();
    recipientNameController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GenericTemplate(
      title: 'Enter recipient details',
      content: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Dimens.marginDefault,
        ),
        child: Form(
          child: Column(
            spacing: 10,
            children: [
              AfriflexTextInput(
                controller: phoneNumberController,
                label: 'Phone number',
                validateOnInput: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a phone number';
                  }
                  return null;
                },
              ),
              AfriflexDropdown(
                controller: recipientModeController,
                label: 'Recipient mode',
                items: const [
                  DropdownItem(
                    label: 'Bank account',
                    value: 'bank',
                  ),
                  DropdownItem(
                    label: 'Mobile money',
                    value: 'mobile',
                  ),
                ],
                onChanged: (value) {},
                height: 200,
                width: MediaQuery.sizeOf(context).width / 1.1,
              ),
              AfriflexTextInput(
                label: 'Recipient name',
                validateOnInput: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a recipient name';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              AfriflexButton(
                title: 'Confirm',
                onTap: () async {
                  _formKey.currentState?.validate();
                  if (_formKey.currentState?.validate() ?? false) {
                    try {
                      context.pushNamed(
                        AfriflexRoutes.homeRoute,
                      );
                    } catch (e) {
                      print(e);
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
      actions: [],
      backgroundColor: ThemeColors.whiteColor,
    );
  }
}
