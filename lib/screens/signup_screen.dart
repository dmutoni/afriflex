import 'package:afriflex/enums/route_configurations/afriflex_routes.dart';
import 'package:afriflex/helpers/validation_helper.dart';
import 'package:afriflex/values/colors.dart';
import 'package:afriflex/values/dimens.dart';
import 'package:afriflex/widgets/common/input/afriflex_button.dart';
import 'package:afriflex/widgets/common/input/afriflex_text_input.dart';
import 'package:afriflex/widgets/templates/generic_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool isShowingPassword = false;
  bool isShowingConfirmPassword = false;

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    emailController.dispose();
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return GenericTemplate(
      title: '',
      backgroundColor: ThemeColors.whiteColor,
      content: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Dimens.marginDefault,
        ),
        child: Form(
          key: formKey,
          child: Column(
            spacing: Dimens.marginDefault,
            children: [
              Text(
                'Welcome!',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Text('Create an account'),
              AfriflexTextInput(
                controller: emailController,
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
                controller: nameController,
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
              IntlPhoneField(
                decoration: const InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: ThemeColors.lightGray2,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        Dimens.radiusDefault,
                      ),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: ThemeColors.orangeColor,
                    ),
                  ),
                ),
                initialCountryCode: 'IN',
                onChanged: (phone) {
                  print(phone.completeNumber);
                },
                validator: (value) {
                  if (value == null) {
                    return 'Phone number is required';
                  }
                  return null;
                },
              ),
              AfriflexTextInput(
                controller: phoneController,
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
                controller: passwordController,
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
                controller: confirmPasswordController,
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
      ),
      actions: [
        AfriflexButton(
          title: 'START',
          onTap: () async {
            if (formKey.currentState?.validate() ?? false) {
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
    );
  }
}
