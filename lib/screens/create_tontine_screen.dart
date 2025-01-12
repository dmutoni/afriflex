import 'package:afriflex/values/colors.dart';
import 'package:afriflex/values/dimens.dart';
import 'package:afriflex/widgets/common/afriflex_dropdown.dart';
import 'package:afriflex/widgets/common/input/afriflex_button.dart';
import 'package:afriflex/widgets/common/input/afriflex_text_input.dart';
import 'package:afriflex/widgets/templates/generic_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
  final TextEditingController numberOfMembers = TextEditingController();
  final TextEditingController purposeOfTime = TextEditingController();
  final TextEditingController frequencyController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
              ),
              AfriflexTextInput(
                controller: contributionAmountController,
                label: 'Contribution amount',
              ),
              AfriflexDropdown(
                controller: frequencyController,
                label: 'Frequency',
                items: const [
                  DropdownItem(
                    label: 'Weekly',
                    value: 'Weekly',
                  ),
                  DropdownItem(
                    label: 'Monthly',
                    value: 'Montly',
                  ),
                  DropdownItem(
                    label: 'Yearly',
                    value: 'Yearly',
                  ),
                ],
                onChanged: (value) {},
                height: 200,
                width: MediaQuery.sizeOf(context).width / 1.1,
              ),
              const AfriflexTextInput(
                label: 'Number of members',
              ),
              const AfriflexTextInput(
                label: 'Purpose of the time',
              ),
            ],
          ),
        ),
      ),
      backgroundColor: ThemeColors.whiteColor,
      actions: [
        AfriflexButton(
          title: 'Create tontine',
          onTap: () {},
        )
      ],
    );
  }
}
