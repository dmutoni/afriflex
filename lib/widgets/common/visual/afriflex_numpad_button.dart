import 'package:afriflex/enums/widget_configurations/afriflex_numpad_variations.dart';
import 'package:afriflex/theme/styles.dart';
import 'package:afriflex/values/duration_values.dart';
import 'package:afriflex/widgets/common/input/afriflex_material_button.dart';
import 'package:flutter/material.dart';

class AfriflexNumpadButton extends StatefulWidget {
  final int value;
  final VoidCallback onTap;
  final AfriflexNumpadVariant variant;
  final bool isDarkMode;

  const AfriflexNumpadButton({
    super.key,
    required this.value,
    required this.onTap,
    required this.isDarkMode,
    this.variant = AfriflexNumpadVariant.grey,
  });

  @override
  _AfriflexNumpadButtonState createState() => _AfriflexNumpadButtonState();
}

class _AfriflexNumpadButtonState extends State<AfriflexNumpadButton>
    with SingleTickerProviderStateMixin {
  late Animation<Color?> bodyAnimation;
  late Animation<Color?> borderAnimation;
  late Animation<Color?> textAnimation;
  late AnimationController controller;
  bool colorSelected = false;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: DurationValues.fast, vsync: this);
    bodyAnimation = ColorTween(
      begin: widget.variant.unselectedButtonColor,
      end: widget.variant.selectedButtonColor,
    ).animate(controller)
      ..addListener(() => setState(() {}));
    borderAnimation = ColorTween(
      begin: widget.variant.unselectedBorderColor,
      end: widget.variant.selectedBorderColor,
    ).animate(controller)
      ..addListener(() => setState(() {}));
    textAnimation = ColorTween(
      begin: widget.variant.unselectedTextColor,
      end: widget.variant.selectedTextColor,
    ).animate(controller)
      ..addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AfriflexMaterialButton.Create(
        color: Colors.transparent,
        elevation: 0.0,
        highlightElevation: 0.0,
        splashColor: Colors.transparent,
        animationDuration: DurationValues.fast,
        onPressed: () {
          widget.onTap();
        },
        tapProtectionMilliseconds: DurationValues.fast.inMilliseconds,
        shape: const CircleBorder(),
        child: Listener(
          onPointerCancel: (_) {
            controller.reverse(from: 1.0);
          },
          onPointerDown: (_) {
            controller.forward();
          },
          onPointerUp: (_) {
            controller.reverse(from: 1.0);
          },
          child: Container(
            height: 72,
            width: 72,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: borderAnimation.value!),
              color: bodyAnimation.value,
            ),
            child: Center(
              child: Text(
                widget.value.toString(),
                style: Styles.h2Heading.copyWith(color: textAnimation.value!),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      );
}
