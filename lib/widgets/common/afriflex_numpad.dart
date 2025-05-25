import 'package:afriflex/enums/widget_configurations/afriflex_numpad_variations.dart';
import 'package:afriflex/values/colors.dart';
import 'package:afriflex/values/dimens.dart';
import 'package:afriflex/values/duration_values.dart';
import 'package:afriflex/widgets/common/input/protected_gesture_helper.dart';
import 'package:afriflex/widgets/common/visual/afriflex_numpad_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class _Constants {
  static const circleProgressHeightFactor = 7.7;
  static const opacityMin = 0.25;
  static const opacityMax = 1.0;
  static const widthNumpadExtras = 106.0;
}

class AfriflexNumpad extends ConsumerWidget {
  final TextEditingController controller;
  final int length;
  final bool shouldDisplayForgotPrompt;
  final AfriflexNumpadVariant variant;
  final bool isLoading;
  final bool isDarkMode;

  const AfriflexNumpad({
    super.key,
    required this.isDarkMode,
    required this.controller,
    required this.length,
    required this.variant,
    this.shouldDisplayForgotPrompt = false,
    this.isLoading = false,
  });

  Widget _buildButton(int number) => AfriflexNumpadButton(
        isDarkMode: isDarkMode,
        key: Key(number.toString()),
        variant: variant,
        value: number,
        onTap: () {
          if (controller.text.length < length) {
            controller.value = TextEditingValue(
              text: controller.text + number.toString(),
            );
          }
        },
      );

  @override
  Widget build(BuildContext context, WidgetRef ref) => Stack(
        children: [
          AnimatedOpacity(
            duration: DurationValues.fast,
            opacity: isLoading ? _Constants.opacityMin : _Constants.opacityMax,
            child: Container(
              decoration: BoxDecoration(
                gradient: ThemeColors.primaryColor,
                borderRadius: BorderRadius.circular(Dimens.radiusMedium),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildButton(1),
                      _buildButton(2),
                      _buildButton(3),
                    ],
                  ),
                  const SizedBox(height: Dimens.marginMedium),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildButton(4),
                      _buildButton(5),
                      _buildButton(6),
                    ],
                  ),
                  const SizedBox(height: Dimens.marginMedium),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildButton(7),
                      _buildButton(8),
                      _buildButton(9),
                    ],
                  ),
                  const SizedBox(height: Dimens.marginMedium),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 120,
                      ),
                      _buildButton(0),
                      SizedBox(
                        width: _Constants.widthNumpadExtras,
                        child: ProtectedGestureDetector.Create(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            if (controller.text.isNotEmpty) {
                              String text = controller.text.substring(
                                0,
                                controller.text.length - 1,
                              );
                              controller.value = controller.value.copyWith(
                                text: text,
                              );
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            child: const Icon(
                              Icons.backspace_outlined,
                              color: ThemeColors.whiteColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          isLoading
              ? Center(
                  heightFactor: _Constants.circleProgressHeightFactor,
                  key: const ValueKey(true),
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(
                      variant.unselectedTextColor,
                    ),
                  ),
                )
              : Container(),
        ],
      );
}
