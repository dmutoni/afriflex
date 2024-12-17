import 'package:afriflex/helpers/tap_protection_helper.dart';
import 'package:flutter/material.dart';

class AppProtectedInkWell {
  /// Creates an instance of InkWell
  ///
  /// Adds protection to any provided onTap method blocking any other onTap calls until its protection timer ends
  ///
  /// setting [enableTapProtection] to false will make this widget operate exactly like the default InkWell widget
  ///
  /// if a [tapProtectionMilliseconds] is not defined a default duration defined by the helper class will be used
  ///
  ///
  /// See the [InkWell] class for more details
  static InkWell create({
    Key? key,
    Widget? child,
    GestureTapCallback? onTap,
    GestureTapCallback? onDoubleTap,
    GestureLongPressCallback? onLongPress,
    GestureTapDownCallback? onTapDown,
    GestureTapUpCallback? onTapUp,
    GestureTapCancelCallback? onTapCancel,
    ValueChanged<bool>? onHighlightChanged,
    ValueChanged<bool>? onHover,
    MouseCursor? mouseCursor,
    Color? focusColor,
    Color? hoverColor,
    Color? highlightColor,
    WidgetStateProperty<Color?>? overlayColor,
    Color? splashColor,
    InteractiveInkFeatureFactory? splashFactory,
    double? radius,
    BorderRadius? borderRadius,
    ShapeBorder? customBorder,
    bool? enableFeedback = true,
    bool excludeFromSemantics = false,
    FocusNode? focusNode,
    bool canRequestFocus = true,
    ValueChanged<bool>? onFocusChange,
    bool autofocus = false,
    bool enableTapProtection = true,
    int? tapProtectionMilliseconds,
    bool? awaitOnTap, // this will error if onTap is not asyncronous
  }) {
    // widget is passed by reference into the tap protection helper
    InkWell? widget;
    widget = InkWell(
      key: key,
      onTap: enableTapProtection
          ? () => TapProtectionHelper.protect(() => onTap?.call(),
              delayDurationMilliseconds: tapProtectionMilliseconds,
              asyncWidget:
                  awaitOnTap != null && awaitOnTap == true ? widget : null)
          : onTap,
      onDoubleTap: onDoubleTap,
      onLongPress: onLongPress,
      onTapDown: onTapDown,
      onTapUp: onTapUp,
      onTapCancel: onTapCancel,
      onHighlightChanged: onHighlightChanged,
      onHover: onHover,
      mouseCursor: mouseCursor,
      focusColor: focusColor,
      hoverColor: hoverColor,
      highlightColor: highlightColor,
      overlayColor: overlayColor,
      splashColor: splashColor,
      splashFactory: splashFactory,
      radius: radius,
      borderRadius: borderRadius,
      customBorder: customBorder,
      enableFeedback: enableFeedback ?? true,
      excludeFromSemantics: excludeFromSemantics,
      focusNode: focusNode,
      canRequestFocus: canRequestFocus,
      onFocusChange: onFocusChange,
      autofocus: autofocus,
      child: child,
    );
    return widget;
  }
}
