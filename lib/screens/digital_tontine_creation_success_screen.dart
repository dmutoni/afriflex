import 'package:afriflex/enums/widget_configurations/app_button_variant.dart';
import 'package:afriflex/values/colors.dart';
import 'package:afriflex/values/dimens.dart';
import 'package:afriflex/widgets/common/input/afriflex_button.dart';
import 'package:afriflex/widgets/templates/generic_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DigitalTontineCreationSuccessScreen extends ConsumerStatefulWidget {
  const DigitalTontineCreationSuccessScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DigitalTontineCreationSuccessScreenState();
}

class _DigitalTontineCreationSuccessScreenState
    extends ConsumerState<DigitalTontineCreationSuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return GenericTemplate(
      title: 'Add members',
      content: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(
            Dimens.marginDefault,
          ),
          child: Column(
            spacing: 10,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 200,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        'assets/images/tontine/tontine_success.png',
                      ),
                      fit: BoxFit.fitHeight
                      // fit: BoxFit.cover,
                      ),
                ),
                child: Center(
                  child: Text(
                    '@Ikimina 1',
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                ),
              ),
              Text(
                'Invite members to start contributing.',
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              const Text(
                  'Your friends who haven\'t joined the app are missing out.'),
              const Text('Send them an invite now and help them get started!'),
              Container(),
              AfriflexButton(
                title: 'Select from contacts',
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
                title: 'Generate an invitation link',
                onTap: () {},
                variant: AfriflexButtonVariant.clear,
              ),
            ],
          ),
        ),
      ),
      backgroundColor: ThemeColors.whiteColor,
    );
  }
}
