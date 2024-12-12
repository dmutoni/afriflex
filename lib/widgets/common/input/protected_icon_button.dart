import 'package:afriflex/helpers/tap_protection_helper.dart';
import 'package:afriflex/values/duration_values.dart';
import 'package:flutter/material.dart';

int _defaultProtectionDuration = DurationValues.naturalDelay.inMilliseconds;

/// Wrapper for the [IconButton] class
class ProtectedIconButton {
  /// Creates an instance of [IconButton]
  ///
  /// Adds accidental tap protection to any method provider to [onPressed] blocking any other onPressed calls until its protection timer ends
  ///
  /// setting [enableTapProtection] to false will make this widget operate exactly like the default InkWell widget
  ///
  /// if a [tapProtectionMilliseconds] is not defined a default duration defined by the helper class will be used
  ///
  ///
  /// See the [IconButton] class for more details
  static IconButton Create({
    Key? key,
    double? iconSize,
    VisualDensity? visualDensity,
    EdgeInsetsGeometry padding = const EdgeInsets.all(8.0),
    AlignmentGeometry alignment = Alignment.center,
    double? splashRadius,
    required Widget icon,
    Color? focusColor,
    Color? hoverColor,
    Color? color,
    Color? splashColor,
    Color? highlightColor,
    Color? disabledColor,
    required VoidCallback? onPressed,
    MouseCursor? mouseCursor,
    FocusNode? focusNode,
    bool autofocus = false,
    String? tooltip,
    bool enableFeedback = true,
    BoxConstraints? constraints,
    bool enableTapProtection = true,
    int? tapProtectionMilliseconds,
    bool? awaitOnTap, // this will error if onTap is not asyncronous
  }) {
    // workaround for non const default value
    int _tapProtectionMilliseconds =
        tapProtectionMilliseconds ?? _defaultProtectionDuration;

    IconButton? widget;
    widget = IconButton(
      key: key,
      iconSize: iconSize,
      visualDensity: visualDensity,
      padding: padding,
      alignment: alignment,
      splashRadius: splashRadius,
      icon: icon,
      focusColor: focusColor,
      hoverColor: hoverColor,
      color: color,
      splashColor: splashColor,
      highlightColor: highlightColor,
      disabledColor: disabledColor,
      onPressed: enableTapProtection
          ? () => TapProtectionHelper.protect(() => onPressed?.call(),
              delayDurationMilliseconds: _tapProtectionMilliseconds,
              asyncWidget:
                  awaitOnTap != null && awaitOnTap == true ? widget : null)
          : onPressed,
      mouseCursor: mouseCursor,
      focusNode: focusNode,
      autofocus: autofocus,
      tooltip: tooltip,
      enableFeedback: enableFeedback,
      constraints: constraints,
    );

    return widget;
  }
}
