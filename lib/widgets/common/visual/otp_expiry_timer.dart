import 'package:afriflex/enums/widget_configurations/afriflex_top_snackbar_level.dart';
import 'package:afriflex/enums/widget_configurations/afriflex_top_snackbar_variant.dart';
import 'package:afriflex/helpers/snackbar_helper.dart';
import 'package:afriflex/values/dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OtpExpiryTimer extends ConsumerStatefulWidget {
  final AnimationController controller;

  const OtpExpiryTimer({
    super.key,
    required this.controller,
  });

  @override
  ConsumerState<OtpExpiryTimer> createState() => _OtpExpiryTimerState();
}

class _OtpExpiryTimerState extends ConsumerState<OtpExpiryTimer> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: Dimens.otpExpiryTimeInSeconds), () {
      if (widget.controller.isCompleted) {
        setState(
          () {
            SnackbarHelper.showSnackbar(
              message: 'OTP has expired',
              level: AfriflexTopSnackbarLevel.alert,
              variant: AfriflexTopSnackbarVariant.message,
              context: context,
            );
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Countdown(
      animation: StepTween(
        begin: Dimens.otpExpiryTimeInSeconds,
        end: 0,
      ).animate(widget.controller),
    );
  }
}

class Countdown extends AnimatedWidget {
  final Animation<int> animation;

  const Countdown({
    super.key,
    required this.animation,
  }) : super(listenable: animation);

  @override
  Widget build(BuildContext context) {
    Duration clockTimer = Duration(seconds: animation.value);
    bool hasCodeExpired =
        clockTimer.inMinutes == 0 && clockTimer.inSeconds == 0;

    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: Dimens.marginDefault,
        ),
        child: hasCodeExpired
            ? Text(
                'Your code has expired',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontFeatures: [
                    const FontFeature.tabularFigures(),
                  ],
                ),
                textAlign: TextAlign.center,
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Verification code expires in',
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    ' ${clockTimer.inMinutes.remainder(60)} min:${clockTimer.inSeconds.remainder(60).toString().padLeft(2, '0')} sec',
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontFeatures: [
                        const FontFeature.tabularFigures(),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
      ),
    );
  }
}
