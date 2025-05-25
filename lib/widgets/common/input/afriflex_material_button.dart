import 'package:afriflex/helpers/tap_protection_helper.dart';
import 'package:afriflex/values/duration_values.dart';
import 'package:flutter/material.dart';

int _defaultProtectionDuration = DurationValues.onTapDelay.inMilliseconds;

class AfriflexMaterialButton {
  static MaterialButton Create({
    Key? key,
    required VoidCallback? onPressed,
    VoidCallback? onLongPress,
    ValueChanged<bool>? onHighlightChanged,
    MouseCursor? mouseCursor,
    ButtonTextTheme? textTheme,
    Color? textColor,
    Color? disabledTextColor,
    Color? color,
    Color? disabledColor,
    Color? splashColor,
    Color? focusColor,
    Color? hoverColor,
    Color? highlightColor,
    double? elevation,
    double? hoverElevation,
    double? focusElevation,
    double? highlightElevation,
    double? disabledElevation,
    Brightness? colorBrightness,
    Widget? child,
    EdgeInsetsGeometry? padding,
    VisualDensity? visualDensity,
    ShapeBorder? shape,
    Clip clipBehavior = Clip.none,
    FocusNode? focusNode,
    bool autofocus = false,
    Duration? animationDuration,
    MaterialTapTargetSize? materialTapTargetSize,
    double? minWidth,
    double? height,
    bool enableFeedback = true,
    bool enableTapProtection = true,
    int? tapProtectionMilliseconds,
    bool? awaitOnTap, // this will error if onTap is not asyncronous
  }) {
    // work around for non const default value
    int _tapProtectionMilliseconds =
        tapProtectionMilliseconds ?? _defaultProtectionDuration;

    MaterialButton? widget;
    widget = MaterialButton(
      onPressed: enableTapProtection
          ? () => TapProtectionHelper.protect(() => onPressed?.call(),
              delayDurationMilliseconds: _tapProtectionMilliseconds,
              asyncWidget:
                  awaitOnTap != null && awaitOnTap == true ? widget : null)
          : onPressed,
      onLongPress: onLongPress,
      onHighlightChanged: onHighlightChanged,
      mouseCursor: mouseCursor,
      textTheme: textTheme,
      textColor: textColor,
      disabledTextColor: disabledTextColor,
      color: color,
      disabledColor: disabledColor,
      splashColor: splashColor,
      focusColor: focusColor,
      hoverColor: hoverColor,
      highlightColor: highlightColor,
      elevation: elevation,
      hoverElevation: hoverElevation,
      focusElevation: focusElevation,
      highlightElevation: highlightElevation,
      disabledElevation: disabledElevation,
      colorBrightness: colorBrightness,
      child: child,
      padding: padding,
      visualDensity: visualDensity,
      shape: shape,
      clipBehavior: clipBehavior,
      focusNode: focusNode,
      autofocus: autofocus,
      animationDuration: animationDuration,
      materialTapTargetSize: materialTapTargetSize,
      minWidth: minWidth,
      height: height,
      enableFeedback: enableFeedback,
    );

    return widget;
  }
}
