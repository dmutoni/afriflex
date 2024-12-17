import 'package:flutter/material.dart';

class TapProtectionHelper {
  static bool _isTapEnabled = true;
  static final int _defaultDelayDuration = Durations.short2.inMilliseconds;

  static int? _blockedWidgetHash;

  static Future<dynamic> protect(Function function,
      {int? delayDurationMilliseconds, Widget? asyncWidget}) async {
    // If a tap was recently triggered, ignore tap
    if (!_isTapEnabled) return;
    // If we are waiting on a buttons future to complete, block futher calls
    if (asyncWidget.hashCode == _blockedWidgetHash) return;

    // Flag that a tap has been triggered
    _isTapEnabled = false;

    // Wait for either the provided duration or default duration if none provided, then allow further button presses
    // Future setup before triggering onTap so button protection still resets if onTap errors
    Future.delayed(Duration(
            milliseconds: delayDurationMilliseconds ?? _defaultDelayDuration))
        .then((_) {
      _isTapEnabled = true;
    });

    // if we are supplied a widget, trigger onTap then block further
    // calls to the given widget until it completes
    if (asyncWidget != null) {
      _blockedWidgetHash = asyncWidget.hashCode;
      Future<dynamic> onTapCallback = function();
      onTapCallback.whenComplete(() => _blockedWidgetHash = null);
    } else {
      // Call the button onTap
      function();
    }
  }
}
