import 'package:afriflex/api/tontines_api.dart';
import 'package:afriflex/enums/route_configurations/afriflex_routes.dart';
import 'package:afriflex/enums/widget_configurations/afriflex_top_snackbar_level.dart';
import 'package:afriflex/enums/widget_configurations/afriflex_top_snackbar_variant.dart';
import 'package:afriflex/helpers/snackbar_helper.dart';
import 'package:afriflex/models/dto/tontines_dto.dart';
import 'package:afriflex/providers/auth_provider.dart';
import 'package:afriflex/values/colors.dart';
import 'package:afriflex/values/dimens.dart';
import 'package:afriflex/widgets/common/afriflex_dropdown.dart';
import 'package:afriflex/widgets/common/input/afriflex_button.dart';
import 'package:afriflex/widgets/common/input/afriflex_text_input.dart';
import 'package:afriflex/widgets/templates/generic_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CreateTontineScreen extends ConsumerStatefulWidget {
  const CreateTontineScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateTontineScreenState();
}

class _CreateTontineScreenState extends ConsumerState<CreateTontineScreen> {
  final TextEditingController tontineNameController = TextEditingController();
  final TextEditingController contributionAmountController =
      TextEditingController();
  final TextEditingController numberOfMembersController = TextEditingController();
  final TextEditingController purposeController= TextEditingController();
  final TextEditingController frequencyController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isSubmitting = false;

  void _createTontine(BuildContext context) async {
    if (frequencyController.text.isEmpty) {
      SnackbarHelper.showSnackbar(
        message: 'Please select a frequency',
        level: AfriflexTopSnackbarLevel.alert,
        variant: AfriflexTopSnackbarVariant.error,
        context: context,
      );
      return;
    }
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isSubmitting = true;
      });

      try {
        await createTontine(
          CreateTontineDto(
            name: tontineNameController.text, 
            contributionAmount: int.tryParse(contributionAmountController.text) ?? 100, 
            frequency: frequencyController.text, 
            numberOfMembers: int.tryParse(numberOfMembersController.text) ?? 1, 
            purpose: purposeController.text
          ), 
          ref.read(authProvider).accessToken ?? '',
        );
        if (context.mounted) {
          SnackbarHelper.showSnackbar(
            level: AfriflexTopSnackbarLevel.alert,
            context: context,
            message: 'Tontine created successfully',
          );
          
          context.pushNamed(
            AfriflexRoutes.addMembersRoute,
          );
        }
      } catch (e) {
        if (context.mounted) {
          SnackbarHelper.showSnackbar(
            message: 'Failed to create tontine',
            level: AfriflexTopSnackbarLevel.alert,
            variant: AfriflexTopSnackbarVariant.error,
            context: context,
          );
        }
      } finally {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GenericTemplate(
      isScrollable: true,
      title: 'Create tontine',
      content: Container(
        padding: const EdgeInsets.all(
          Dimens.marginDefault,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            spacing: 10,
            children: [
              AfriflexTextInput(
                controller: tontineNameController,
                label: 'Tontine name',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a tontine name';
                  }
                  return null;
                },
              ),
              AfriflexTextInput(
                controller: contributionAmountController,
                label: 'Contribution amount',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a contribution amount';
                  }
                  final number = double.tryParse(value);
                  if (number == null || number <= 0) {
                    return 'Please enter a valid amount greater than 0';
                  }
                  return null;
                },
              ),
              AfriflexDropdown(
                controller: frequencyController,
                label: 'Frequency',
                items: const [
                  DropdownItem(
                    label: 'Weekly',
                    value: 'WEEKLY',
                  ),
                  DropdownItem(
                    label: 'Monthly',
                    value: 'MONTHLY',
                  ),
                  DropdownItem(
                    label: 'Yearly',
                    value: 'YEARLY',
                  ),
                ],
                onChanged: (value) {},
                height: 200,
                width: MediaQuery.sizeOf(context).width / 1.1,
              ),
              AfriflexTextInput(
                label: 'Number of members',
                controller: numberOfMembersController,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a number';
                  }
                  final number = int.tryParse(value);
                  if (number == null || number <= 0) {
                    return 'Please enter a valid number greater than 0';
                  }
                  return null;
                },
              ),
              AfriflexTextInput(
                label: 'Purpose of the tontine',
                controller: purposeController,
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter the purpose of the tontine'
                    : null,
              ),
            ],
          ),
        ),
      ),
      backgroundColor: ThemeColors.whiteColor,
      actions: [
        AfriflexButton(
          title: 'Create tontine',
          isLoading: _isSubmitting,
          onTap: () => _createTontine(context),
        )
      ],
    );
  }
}
