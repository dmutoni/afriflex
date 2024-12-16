import 'package:afriflex/enums/route_configurations/afriflex_routes.dart';
import 'package:afriflex/enums/widget_configurations/app_button_variant.dart';
import 'package:afriflex/helpers/validation_helper.dart';
import 'package:afriflex/values/colors.dart';
import 'package:afriflex/values/dimens.dart';
import 'package:afriflex/widgets/common/input/afriflex_button.dart';
import 'package:afriflex/widgets/common/input/afriflex_text_input.dart';
import 'package:afriflex/widgets/templates/generic_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/svg.dart';

class EmailEntryScreen extends ConsumerStatefulWidget {
  const EmailEntryScreen({super.key});

  @override
  ConsumerState<EmailEntryScreen> createState() => _EmailEntryScreenState();
}

class _EmailEntryScreenState extends ConsumerState<EmailEntryScreen> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GenericTemplate(
      title: '',
      backgroundColor: ThemeColors.whiteColor,
      isScrollable: true,
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimens.marginDefault),
        child: Column(
          children: [
            Text(
              'Registration',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: Dimens.marginBig,
            ),
            Text(
              'Enter your e-mail address, we will send you OTP to verify later.',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: ThemeColors.grayDark,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: Dimens.marginBig,
            ),
            AfriflexTextInput(
              controller: _emailController,
              label: 'Email address',
              isRequired: true,
              validateOnInput: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Email is required';
                }
                if (!isEmailValid(value)) {
                  return 'Please enter your email in format: yourname@example.com';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 50,
            ),
            SvgPicture.asset(
              'assets/images/onboarding/email_illustrations.svg',
              height: 150,
              width: Dimens.radiusDefault,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
      actions: [
        Center(
          child: RichText(
            textAlign: TextAlign.center,
            textHeightBehavior: const TextHeightBehavior(
              applyHeightToFirstAscent: false,
            ),
            text: TextSpan(
              text: 'By creating and/or using an account, you agree to our ',
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    color: ThemeColors.grayDark,
                    fontSize: 12,
                  ),
              children: [
                TextSpan(
                  text: 'Terms of Service & conditions.',
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        color: ThemeColors.orangeColor,
                        fontSize: 12,
                      ),
                ),
              ],
            ),
          ),
        ),
        AfriflexButton(
          title: 'Continue',
          onTap: () {
            context.pushNamed(AfriflexRoutes.otpCodeRoute);
          },
        ),
        AfriflexButton(
          title: 'Login',
          onTap: () {
            context.pushNamed(AfriflexRoutes.loginRoute);
          },
          variant: AfriflexButtonVariant.clear,
        ),
      ],
    );
  }
}
