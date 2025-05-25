import 'package:afriflex/values/colors.dart';
import 'package:flutter/material.dart';

enum AfriflexNumpadVariant { white, grey }

extension AfriflexInputVariantValues on AfriflexNumpadVariant {
  Color get filledDotBackgroundColor {
    switch (this) {
      case AfriflexNumpadVariant.grey:
        return ThemeColors.whiteColor;
      case AfriflexNumpadVariant.white:
        return ThemeColors.orangeColor.withOpacity(0.2);
    }
  }

  Color get selectedBorderColor {
    switch (this) {
      case AfriflexNumpadVariant.grey:
        return Colors.transparent;
      case AfriflexNumpadVariant.white:
        return Colors.transparent;
    }
  }

  Color get selectedButtonColor {
    switch (this) {
      case AfriflexNumpadVariant.grey:
        return Colors.transparent;
      case AfriflexNumpadVariant.white:
        return ThemeColors.orangeColor;
    }
  }

  Color get selectedTextColor {
    switch (this) {
      case AfriflexNumpadVariant.grey:
        return ThemeColors.whiteColor;
      case AfriflexNumpadVariant.white:
        return ThemeColors.whiteColor;
    }
  }

  Color get unfilledDotBackgroundColor {
    switch (this) {
      case AfriflexNumpadVariant.grey:
        return Colors.transparent;
      case AfriflexNumpadVariant.white:
        return ThemeColors.whiteColor;
    }
  }

  Color get unselectedBorderColor {
    switch (this) {
      case AfriflexNumpadVariant.grey:
        return Colors.transparent;
      case AfriflexNumpadVariant.white:
        return ThemeColors.whiteColor;
    }
  }

  Color get unselectedButtonColor {
    switch (this) {
      case AfriflexNumpadVariant.grey:
        return Colors.transparent;
      case AfriflexNumpadVariant.white:
        return ThemeColors.whiteColor;
    }
  }

  Color get unselectedTextColor {
    switch (this) {
      case AfriflexNumpadVariant.grey:
        return ThemeColors.whiteColor;
      case AfriflexNumpadVariant.white:
        return ThemeColors.orangeColor;
    }
  }
}
