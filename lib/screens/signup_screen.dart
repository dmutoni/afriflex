import 'package:afriflex/helpers/validation_helper.dart';
import 'package:afriflex/values/colors.dart';
import 'package:afriflex/values/dimens.dart';
import 'package:afriflex/widgets/common/input/afriflex_button.dart';
import 'package:afriflex/widgets/common/input/afriflex_text_input.dart';
import 'package:afriflex/widgets/templates/generic_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController passwordController = TextEditingController();

    final TextEditingController confirmPasswordController =
        TextEditingController();

    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    bool isShowingPassword = false;
    bool isShowingConfirmPassword = false;

    @override
    void dispose() {
      passwordController.dispose();
      confirmPasswordController.dispose();
      super.dispose();
    }

    return GenericTemplate(
      title: '',
      backgroundColor: ThemeColors.whiteColor,
      content: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Dimens.marginDefault,
        ),
        child: Column(
          spacing: Dimens.marginDefault,
          children: [
            Text(
              'Welcome!',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Text('Create an account'),
            AfriflexTextInput(
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
            AfriflexTextInput(
              label: 'Name',
              isRequired: true,
              validateOnInput: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Name is required';
                }
                return null;
              },
            ),
            AfriflexTextInput(
              label: 'Phone number',
              isRequired: true,
              validateOnInput: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Phone number is required';
                }
                return null;
              },
            ),
            AfriflexTextInput(
              label: 'Password',
              isRequired: true,
              obscureText: isShowingPassword,
              validateOnInput: true,
              trailingWidgetOverride: IconButton(
                onPressed: () => setState(
                  () => isShowingPassword = !isShowingPassword,
                ),
                icon: !isShowingPassword
                    ? const Icon(
                        Icons.visibility_outlined,
                      )
                    : const Icon(
                        Icons.visibility_off_outlined,
                      ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Password is required';
                } else if (value.length < 6) {
                  return 'Password must be at least 6 characters';
                } else if (!RegExp(r'[0-9]').hasMatch(value) &&
                    !RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
                  return 'Password must contain at least one number or one special character';
                }
                return null;
              },
            ),
            AfriflexTextInput(
              label: 'Confirm password',
              isRequired: true,
              obscureText: isShowingConfirmPassword,
              validateOnInput: true,
              trailingWidgetOverride: IconButton(
                onPressed: () => setState(
                  () => isShowingConfirmPassword = !isShowingConfirmPassword,
                ),
                icon: !isShowingConfirmPassword
                    ? const Icon(
                        Icons.visibility_outlined,
                      )
                    : const Icon(
                        Icons.visibility_off_outlined,
                      ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Confirm password is required';
                } else if (value != passwordController.text) {
                  return 'Passwords do not match';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: [
        AfriflexButton(
          title: 'START',
          onTap: () {},
        ),
      ],
    );
  }
}
