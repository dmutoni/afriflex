import 'package:afriflex/values/colors.dart';
import 'package:flutter/material.dart';

enum AppButtonVariant { dark, light }

extension AppButtonVariantContent on AppButtonVariant {
  Color get textColor {
    switch (this) {
      case AppButtonVariant.dark:
        return ThemeColors.whiteColor;
      case AppButtonVariant.light:
        return ThemeColors.whiteColor;
    }
  }

  LinearGradient get backgroundColor {
    switch (this) {
      case AppButtonVariant.dark:
        return ThemeColors.primaryColor;
      case AppButtonVariant.light:
        return ThemeColors.primaryColor;
    }
  }

  Color get disabledTextColor {
    switch (this) {
      case AppButtonVariant.dark:
        return ThemeColors.whiteColor;
      case AppButtonVariant.light:
        return ThemeColors.whiteColor;
    }
  }

  LinearGradient get disabledBackgroundColor {
    switch (this) {
      case AppButtonVariant.dark:
        return ThemeColors.primaryColor;
      case AppButtonVariant.light:
        return ThemeColors.primaryColor;
    }
  }

  Color get borderColor {
    switch (this) {
      case AppButtonVariant.dark:
        return Colors.transparent;
      case AppButtonVariant.light:
        return Colors.transparent;
    }
  }
}
