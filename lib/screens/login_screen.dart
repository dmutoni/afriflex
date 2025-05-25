import 'package:afriflex/enums/route_configurations/afriflex_routes.dart';
import 'package:afriflex/enums/widget_configurations/afriflex_top_snackbar_level.dart';
import 'package:afriflex/enums/widget_configurations/afriflex_top_snackbar_variant.dart';
import 'package:afriflex/enums/widget_configurations/app_button_variant.dart';
import 'package:afriflex/helpers/snackbar_helper.dart';
import 'package:afriflex/helpers/validation_helper.dart';
import 'package:afriflex/models/dto/auth_dto.dart';
import 'package:afriflex/providers/auth_provider.dart';
import 'package:afriflex/values/colors.dart';
import 'package:afriflex/values/dimens.dart';
import 'package:afriflex/widgets/common/input/afriflex_button.dart';
import 'package:afriflex/widgets/common/input/afriflex_text_input.dart';
import 'package:afriflex/widgets/common/visual/afriflex_or_widget.dart';
import 'package:afriflex/widgets/templates/generic_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isShowingPassword = true;

  void _handleSignIn(BuildContext context, WidgetRef ref) async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        await ref.read(authProvider.notifier).signIn(
          SignInReqBodyDto(
            login: _emailController.text,
            password: _passwordController.text,
          ),
        );
        if (context.mounted) {
          context.pushNamed(AfriflexRoutes.otpCodeRoute);
        }
      } catch (error) {
        if (context.mounted) {
          SnackbarHelper.showSnackbar(
            message: 'Invalid credentials, please try again.',
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
    _passwordController.dispose();
    super.dispose();
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
          key: _formKey,
          child: Column(
            spacing: Dimens.marginDefault,
            children: [
              Text(
                'Welcome!',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Dimens.marginDefault,
                ),
                child: Text(
                  'Please enter your login credentials, to access your account!',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
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
                    return 'Please enter your email address';
                  }
                  return null;
                },
              ),
              AfriflexTextInput(
                controller: _passwordController,
                label: 'Password',
                isRequired: true,
                obscureText: !_isShowingPassword,
                validateOnInput: true,
                trailingWidgetOverride: IconButton(
                  onPressed: () => setState(
                    () => _isShowingPassword = !_isShowingPassword,
                  ),
                  icon: !_isShowingPassword
                      ? const Icon(
                          Icons.visibility_outlined,
                        )
                      : const Icon(
                          Icons.visibility_off_outlined,
                        ),
                ),
                validator: (value) {
                  if (value == null) {
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
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Forgot password?',
                ),
              ),
              AfriflexButton(
                title: 'LOGIN',
                // isEnabled: _formKey.currentState?.validate() ?? false,
                onTap: () => _handleSignIn(context, ref),
              ),
              const AfriflexOrWidget(),
              AfriflexButton(
                title: 'SIGN UP',
                variant: AfriflexButtonVariant.clear,
                onTap: () {
                  context.pushNamed(
                    AfriflexRoutes.signupRoute,
                  );
                },
              ),
            ],
          ),
        ),
      ),
      actions: const [],
    );
  }
}
