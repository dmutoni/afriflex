import 'package:afriflex/enums/widget_configurations/afriflex_top_snackbar_level.dart';
import 'package:afriflex/enums/widget_configurations/afriflex_top_snackbar_variant.dart';
import 'package:afriflex/widgets/common/visual/afriflex_top_snackbar.dart';
import 'package:flutter/material.dart';

OverlayEntry? _currentEntry;
List<OverlayEntry> _queue = [];

abstract class SnackbarHelper {
  static clearQueue() {
    _queue = [];
  }

  static showSnackbar({
    required String message,
    required AfriflexTopSnackbarLevel level,
    AfriflexTopSnackbarVariant variant = AfriflexTopSnackbarVariant.message,
    VoidCallback? onTap,
    Duration closeInterval = Durations.extralong2,
    required BuildContext context,
  }) async {
    OverlayState? overlayState = Overlay.of(context);
    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) {
        return AfriflexTopSnackbar(
          closeInterval: closeInterval,
          message: message,
          variant: variant,
          onDismissed: () {
            overlayEntry.remove();
            if (_queue.isNotEmpty) {
              _currentEntry = _queue.removeAt(0);
              overlayState.insert(_currentEntry!);
            } else {
              _currentEntry = null;
            }
          },
        );
      },
    );

    if (_currentEntry != null) {
      _queue.add(overlayEntry);
    } else {
      overlayState.insert(overlayEntry);
      _currentEntry = overlayEntry;
    }
  }
}
