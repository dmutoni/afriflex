import 'package:flutter/material.dart';

abstract class ThemeColors {
  static const whiteColor = Color(0xFFFFFFFF);
  static const blackColor = Color(0xFF000000);
  static const orangeColor = Color(0xFFF59421);
  static const grayLight = Color(0xFFE5E5E5);
  static const grayDark = Color(0xFFA1A1A1);

  static const primaryColor = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Color(0xFF000000), // Black color
      Color(0xFFF59421), // Orange color
    ],
  );
}

@immutable
class AppColors extends ThemeExtension<AppColors> {
  final LinearGradient? primaryColorGradient;
  final Color? primaryColor;
  final Color? secondaryColor;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? accentColor;
  final Color? successColor;
  final Color? errorColor;
  final Color? iconColor;
  final Color? secondaryTextColor;

  const AppColors({
    this.primaryColorGradient,
    this.primaryColor,
    this.secondaryColor,
    this.backgroundColor,
    this.textColor,
    this.accentColor,
    this.successColor,
    this.errorColor,
    this.iconColor,
    this.secondaryTextColor,
  });

  @override
  AppColors copyWith({
    final LinearGradient? primaryColorGradient,
    final Color? primaryColor,
    final Color? secondaryColor,
    final Color? backgroundColor,
    final Color? textColor,
    final Color? accentColor,
    final Color? successColor,
    final Color? errorColor,
    final Color? iconColor,
    final Color? secondaryTextColor,
  }) {
    return AppColors(
      primaryColorGradient: primaryColorGradient ?? this.primaryColorGradient,
      primaryColor: primaryColor ?? this.primaryColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      textColor: textColor ?? this.textColor,
      accentColor: accentColor ?? this.accentColor,
      successColor: successColor ?? this.successColor,
      errorColor: errorColor ?? this.errorColor,
      iconColor: iconColor ?? this.iconColor,
      secondaryTextColor: secondaryColor ?? this.secondaryColor,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) {
      return this;
    }
    return AppColors(
      primaryColorGradient: LinearGradient.lerp(
        primaryColorGradient,
        other.primaryColorGradient,
        t,
      ),
      primaryColor: Color.lerp(primaryColor, other.primaryColor, t),
      secondaryColor: Color.lerp(secondaryColor, other.secondaryColor, t),
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t),
      textColor: Color.lerp(textColor, other.textColor, t),
      accentColor: Color.lerp(accentColor, other.accentColor, t),
      successColor: Color.lerp(successColor, other.successColor, t),
      errorColor: Color.lerp(errorColor, other.errorColor, t),
      iconColor: Color.lerp(iconColor, other.iconColor, t),
      secondaryTextColor: (Color.lerp(
        iconColor,
        other.iconColor,
        t,
      )),
    );
  }
}
