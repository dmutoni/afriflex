import 'package:afriflex/values/colors.dart';
import 'package:afriflex/values/dimens.dart';
import 'package:afriflex/widgets/common/input/afriflex_button.dart';
import 'package:afriflex/widgets/common/input/afriflex_text_input.dart';
import 'package:flutter/material.dart';

class SignupScreen1 extends StatefulWidget {
  const SignupScreen1({super.key});

  @override
  State<SignupScreen1> createState() => _SignupScreen1State();
}

class _SignupScreen1State extends State<SignupScreen1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.only(
            left: Dimens.marginMiddle,
            top: 100,
            right: Dimens.marginMiddle,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
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
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      color: ThemeColors.lightGray2,
                    ),
              ),
              const SizedBox(
                height: Dimens.marginBig,
              ),
              AfriflexTextInput(
                label: 'Email',
                isRequired: true,
                validator: (value) =>
                    (value ?? '').isEmpty ? 'Please input the email' : null,
                // hint:
              ),
              const SizedBox(
                height: 30,
              ),
              AfriflexButton(
                title: 'Continue',
                onTap: () {},
              ),
              const SizedBox(
                height: 20,
              ),
              RichText(
                textHeightBehavior: const TextHeightBehavior(
                  applyHeightToFirstAscent: false,
                ),
                text: TextSpan(
                  text: 'Already have an account? ',
                  style: Theme.of(context).textTheme.displaySmall,
                  children: [
                    TextSpan(
                      text: 'Sign in',
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                            color: ThemeColors.orangeColor,
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: Dimens.marginBig,
              ),
              RichText(
                textHeightBehavior: const TextHeightBehavior(
                  applyHeightToFirstAscent: false,
                ),
                text: TextSpan(
                  text:
                      'By creating and/or using an account, you agree to our ',
                  style: Theme.of(context).textTheme.displaySmall,
                  children: [
                    TextSpan(
                      text: 'Terms of Service & conditions.',
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                            color: ThemeColors.orangeColor,
                          ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
