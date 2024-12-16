import 'package:afriflex/enums/route_configurations/afriflex_routes.dart';
import 'package:afriflex/enums/widget_configurations/app_button_variant.dart';
import 'package:afriflex/theme/styles.dart';
import 'package:afriflex/values/colors.dart';
import 'package:afriflex/values/dimens.dart';
import 'package:afriflex/widgets/common/input/afriflex_button.dart';
import 'package:afriflex/widgets/common/visual/otp_expiry_timer.dart';
import 'package:afriflex/widgets/templates/generic_template.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';

class OtpScreen extends ConsumerStatefulWidget {
  const OtpScreen({super.key});

  @override
  ConsumerState<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends ConsumerState<OtpScreen>
    with TickerProviderStateMixin {
  final TextEditingController _pinInputController = TextEditingController();

  final FocusNode _pinInputFocusNode = FocusNode();

  late final AnimationController _countdownController;

  String _pinInputValue = '';
  bool _isResending = false;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();

    _countdownController = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: Dimens.otpExpiryTimeInSeconds,
      ),
    );

    _countdownController.forward();
  }

  @override
  void dispose() {
    _pinInputController.dispose();
    _pinInputFocusNode.dispose();
    _countdownController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GenericTemplate(
      title: '',
      isScrollable: true,
      backgroundColor: ThemeColors.whiteColor,
      content: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Dimens.marginDefault,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Enter Code', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: Dimens.marginBig),
            const Text('Enter the code that was sent to your email address'),
            const SizedBox(height: Dimens.marginBig),
            Pinput(
              key: const Key('pin_put'),
              defaultPinTheme: PinTheme(
                padding: EdgeInsets.zero,
                margin: EdgeInsets.zero,
                decoration: Styles.pinPutDecoration,
                width: Dimens.marginFortySix,
                height: Dimens.inputHeight,
                textStyle: Theme.of(context).textTheme.displayMedium,
              ),
              followingPinTheme: PinTheme(
                padding: EdgeInsets.zero,
                margin: EdgeInsets.zero,
                decoration: Styles.pinPutDecoration,
                width: Dimens.marginFortySix,
                height: Dimens.inputHeight,
                textStyle: Theme.of(context).textTheme.displayMedium,
              ),
              focusedPinTheme: PinTheme(
                padding: EdgeInsets.zero,
                margin: EdgeInsets.zero,
                decoration: Styles.selectedPinPutDecoration,
                width: Dimens.marginFortySix,
                height: Dimens.inputHeight,
                textStyle: Theme.of(context).textTheme.displayMedium,
              ),
              length: 6,
              onChanged: (String pin) {
                setState(() {
                  if (_pinInputValue.length == 5 && pin.length == 6) {
                    _pinInputFocusNode.unfocus();
                  }
                  _pinInputValue = _pinInputController.text;
                });
              },
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a valid code';
                }
                return null;
              },
              focusNode: _pinInputFocusNode,
              controller: _pinInputController,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
            const SizedBox(height: Dimens.marginSeventy),
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
        OtpExpiryTimer(
          controller: _countdownController,
        ),
        AfriflexButton(
          title: 'Verify Code',
          isEnabled: _pinInputValue.length == 6,
          isLoading: _isSubmitting,
          onTap: () async {
            try {
              if (mounted) {
                setState(() {
                  _isSubmitting = true;
                });
              }
              context.pushNamed(AfriflexRoutes.loginRoute);
            } on Exception catch (e) {
              if (kDebugMode) {
                print(e);
              }
            } finally {
              if (mounted) {
                setState(
                  () {
                    _pinInputValue = '';
                    _pinInputController.clear();
                    _isSubmitting = false;
                  },
                );
              }
            }
          },
        ),
        AfriflexButton(
          title: 'Resend Code',
          variant: AfriflexButtonVariant.clear,
          isLoading: _isResending,
          onTap: () async {
            try {
              if (mounted) {
                setState(() {
                  _isResending = true;
                });
              }

              _countdownController.reset();
              _countdownController.forward();
            } on Exception catch (e) {
              if (kDebugMode) {
                print(e);
              }
            } finally {
              if (mounted) {
                setState(() {
                  _isResending = false;
                });
              }
            }
          },
        ),
      ],
    );
  }
}
