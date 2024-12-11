import 'package:afriflex/enums/widget_configurations/app_button_variant.dart';
import 'package:afriflex/helpers/validation_helper.dart';
import 'package:afriflex/values/colors.dart';
import 'package:afriflex/values/dimens.dart';
import 'package:afriflex/widgets/common/input/afriflex_button.dart';
import 'package:afriflex/widgets/common/input/afriflex_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/svg.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: ThemeColors.whiteColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left,
            color: ThemeColors.blackColor,
          ),
          onPressed: () {
            context.pop();
          },
        ),
      ),
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.only(
            left: Dimens.marginMiddle,
            right: Dimens.marginMiddle,
          ),
          child: Column(
            children: [
              Expanded(
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
                    )
                  ],
                ),
              ),
              SafeArea(
                top: false,
                bottom: true,
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      Center(
                        child: RichText(
                          textAlign: TextAlign.center,
                          textHeightBehavior: const TextHeightBehavior(
                            applyHeightToFirstAscent: false,
                          ),
                          text: TextSpan(
                            text:
                                'By creating and/or using an account, you agree to our ',
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall
                                ?.copyWith(
                                  color: ThemeColors.grayDark,
                                  fontSize: 12,
                                ),
                            children: [
                              TextSpan(
                                text: 'Terms of Service & conditions.',
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall
                                    ?.copyWith(
                                      color: ThemeColors.orangeColor,
                                      fontSize: 12,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: Dimens.marginDefault,
                      ),
                      AfriflexButton(
                        title: 'Continue',
                        onTap: () {},
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      AfriflexButton(
                        title: 'Login',
                        onTap: () {},
                        variant: AfriflexButtonVariant.clear,
                      ),
                      const SizedBox(
                        height: Dimens.marginBig,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
