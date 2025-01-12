import 'package:afriflex/values/colors.dart';
import 'package:afriflex/widgets/common/gradient_box_border.dart';
import 'package:flutter/material.dart';

enum AfriflexButtonVariant { dark, light, clear, black }

extension AfriflexButtonVariantContent on AfriflexButtonVariant {
  Color get textColor {
    switch (this) {
      case AfriflexButtonVariant.dark:
        return ThemeColors.whiteColor;
      case AfriflexButtonVariant.light:
        return ThemeColors.whiteColor;
      case AfriflexButtonVariant.clear:
        return ThemeColors.blackColor;
      case AfriflexButtonVariant.black:
        return ThemeColors.whiteColor;
    }
  }

  LinearGradient get backgroundColor {
    switch (this) {
      case AfriflexButtonVariant.dark:
        return ThemeColors.primaryColor;
      case AfriflexButtonVariant.light:
        return ThemeColors.primaryColor;
      case AfriflexButtonVariant.clear:
        return ThemeColors.whiteColorGradient;
      case AfriflexButtonVariant.black:
        return ThemeColors.blackColorGradient;
    }
  }

  Color get disabledTextColor {
    switch (this) {
      case AfriflexButtonVariant.dark:
        return ThemeColors.whiteColor;
      case AfriflexButtonVariant.light:
        return ThemeColors.whiteColor;
      case AfriflexButtonVariant.clear:
        return ThemeColors.whiteColor;
      case AfriflexButtonVariant.black:
        return ThemeColors.whiteColor;
    }
  }

  LinearGradient get disabledBackgroundColor {
    switch (this) {
      case AfriflexButtonVariant.dark:
        return ThemeColors.primaryColor;
      case AfriflexButtonVariant.light:
        return ThemeColors.whiteColorGradient;
      case AfriflexButtonVariant.clear:
        return ThemeColors.whiteColorGradient;
      case AfriflexButtonVariant.black:
        return ThemeColors.blackColorGradient;
    }
  }

  Color get borderColor {
    switch (this) {
      case AfriflexButtonVariant.dark:
        return Colors.transparent;
      case AfriflexButtonVariant.light:
        return Colors.transparent;
      case AfriflexButtonVariant.clear:
        return Colors.transparent;
      case AfriflexButtonVariant.black:
        return Colors.transparent;
    }
  }

  BoxBorder get border {
    switch (this) {
      case AfriflexButtonVariant.dark:
        return Border.all(
          color: Colors.transparent,
          width: 1.0,
        );
      case AfriflexButtonVariant.light:
        return const GradientBoxBorder(
          gradient: ThemeColors.primaryColor,
          width: 1,
        );
      case AfriflexButtonVariant.clear:
        return const GradientBoxBorder(
          gradient: ThemeColors.primaryColor,
          width: 1,
        );
      case AfriflexButtonVariant.black:
        return const GradientBoxBorder(
          gradient: ThemeColors.blackColorGradient,
          width: 0,
        );
    }
  }
}
