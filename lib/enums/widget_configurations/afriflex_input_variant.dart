import 'package:afriflex/theme/styles.dart';
import 'package:afriflex/values/colors.dart';
import 'package:afriflex/values/dimens.dart';
import 'package:flutter/material.dart';

enum AfriflexInputVariant { dark, light, clear, search }

extension AfriflexInputVariantValues on AfriflexInputVariant {
  Color get backgroundColor {
    switch (this) {
      case AfriflexInputVariant.dark:
        return ThemeColors.whiteColor;
      case AfriflexInputVariant.light:
        return ThemeColors.whiteColor;
      case AfriflexInputVariant.clear:
        return Colors.transparent;
      case AfriflexInputVariant.search:
        return ThemeColors.whiteColor;
    }
  }

  Color get disabledBackgroundColor {
    switch (this) {
      case AfriflexInputVariant.dark:
        return ThemeColors.whiteColor;
      case AfriflexInputVariant.light:
        return ThemeColors.whiteColor;
      case AfriflexInputVariant.clear:
        return Colors.transparent;
      case AfriflexInputVariant.search:
        return ThemeColors.grayLight;
    }
  }

  Color get textColor {
    switch (this) {
      case AfriflexInputVariant.dark:
        return ThemeColors.blackColor;
      case AfriflexInputVariant.light:
        return ThemeColors.blackColor;
      case AfriflexInputVariant.clear:
        return ThemeColors.blackColor;
      case AfriflexInputVariant.search:
        return ThemeColors.blackColor;
    }
  }

  Color get disabledTextColor {
    switch (this) {
      case AfriflexInputVariant.dark:
        return ThemeColors.grayLight.withOpacity(0.8);
      case AfriflexInputVariant.light:
        return ThemeColors.grayLight;
      case AfriflexInputVariant.clear:
        return ThemeColors.grayLight;
      case AfriflexInputVariant.search:
        return ThemeColors.grayLight;
    }
  }

  Color get borderColor {
    switch (this) {
      case AfriflexInputVariant.dark:
        return ThemeColors.grayLight;
      case AfriflexInputVariant.light:
        return ThemeColors.grayLight;
      case AfriflexInputVariant.clear:
        return ThemeColors.grayLight;
      case AfriflexInputVariant.search:
        return ThemeColors.grayLight;
    }
  }

  Color get selectedBorderColor {
    switch (this) {
      case AfriflexInputVariant.dark:
        return ThemeColors.orangeColor;
      case AfriflexInputVariant.light:
        return ThemeColors.orangeColor;
      case AfriflexInputVariant.clear:
        return ThemeColors.orangeColor;
      case AfriflexInputVariant.search:
        return ThemeColors.orangeColor;
    }
  }

  double get inputHeight {
    switch (this) {
      case AfriflexInputVariant.dark:
      case AfriflexInputVariant.light:
      case AfriflexInputVariant.clear:
        return Dimens.inputHeight;
      case AfriflexInputVariant.search:
        return Dimens.searchInputHeight;
    }
  }

  TextStyle get errorTextStyle {
    switch (this) {
      case AfriflexInputVariant.search:
      case AfriflexInputVariant.light:
        return Styles.errorTextStyleRed;
      case AfriflexInputVariant.dark:
      case AfriflexInputVariant.clear:
        return Styles.errorTextStyleWhite;
    }
  }

  Widget? get leadingWidget {
    switch (this) {
      case AfriflexInputVariant.search:
        return const Icon(
          Icons.search,
          color: ThemeColors.blackColor,
        );
      case AfriflexInputVariant.dark:
      case AfriflexInputVariant.light:
      case AfriflexInputVariant.clear:
        return null;
    }
  }
}
