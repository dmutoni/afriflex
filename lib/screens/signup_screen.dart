import 'package:afriflex/enums/route_configurations/afriflex_routes.dart';
import 'package:afriflex/enums/widget_configurations/afriflex_top_snackbar_level.dart';
import 'package:afriflex/enums/widget_configurations/afriflex_top_snackbar_variant.dart';
import 'package:afriflex/helpers/snackbar_helper.dart';
import 'package:afriflex/helpers/validation_helper.dart';
import 'package:afriflex/models/dto/auth_dto.dart';
import 'package:afriflex/providers/auth_provider.dart';
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
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool isShowingPassword = false;
  bool isShowingConfirmPassword = false;

  void _handleSignUp(BuildContext context, WidgetRef ref) async {
    formKey.currentState?.validate();
    if (formKey.currentState?.validate() ?? false) {
      try {
        await ref.read(authProvider.notifier).signUp(
          SignUpReqBodyDto(
            firstName: firstNameController.text,
            lastName: lastNameController.text,
            emailAddress: emailController.text,
            phoneNumber: phoneController.text,
            countryId: 1, // Assuming a default country ID
            password: passwordController.text,
          ),
        );
        if (context.mounted) {
          context.pushNamed(AfriflexRoutes.otpCodeRoute);
        }
      } catch (e) {
        if (context.mounted) {
          SnackbarHelper.showSnackbar(
            message: 'Sign up failed, please try again.',
            level: AfriflexTopSnackbarLevel.warning,
            variant: AfriflexTopSnackbarVariant.error,
            context: context,
          );
        }
      }
    }
  }

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    emailController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                controller: firstNameController,
                label: 'First Name',
                isRequired: true,
                validateOnInput: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'First Name is required';
                  }
                  return null;
                },
              ),
              AfriflexTextInput(
                controller: lastNameController,
                label: 'Last Name',
                isRequired: true,
                validateOnInput: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Last Name is required';
                  }
                  return null;
                },
              ),
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
              IntlPhoneField(
                controller: phoneController,
                decoration: const InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: ThemeColors.grayLight,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        Dimens.radiusDefault,
                      ),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: ThemeColors.grayLight,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: ThemeColors.orangeColor,
                    ),
                  ),
                ),
                initialCountryCode: 'IN',
                validator: (value) {
                  if (value == null) {
                    return 'Phone number is required';
                  }
                  return null;
                },
              ),
              AfriflexTextInput(
                label: 'Password',
                controller: passwordController,
                isRequired: true,
                obscureText: !isShowingPassword,
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
                obscureText: !isShowingConfirmPassword,
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
          onTap: () => _handleSignUp(context, ref),
        ),
      ],
    );
  }
}
