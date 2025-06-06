import 'package:afriflex/values/colors.dart';
import 'package:afriflex/values/dimens.dart';
import 'package:flutter/material.dart';

ThemeData getAppTheme({
  required BuildContext context,
  required bool isDarkMode,
}) {
  const poppins = 'Poppins';
  return ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor:
        isDarkMode ? ThemeColors.blackColor : ThemeColors.whiteColor,
    fontFamily: poppins,
    brightness: Brightness.light,
    primaryColor: ThemeColors.orangeColor,
    textTheme: TextTheme(
      titleLarge: TextStyle(
        fontSize: 30,
        // fontStyle: FontStyle.italic,
        fontWeight: FontWeight.w800,
        foreground: Paint()
          ..shader = ThemeColors.primaryColor.createShader(
            const Rect.fromLTWH(0, 0, 200, 70), // Adjust size as needed
          ),
      ),
      bodySmall: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: ThemeColors.whiteColor,
        height: 1.5,
        letterSpacing: 0.6,
      ),
      bodyLarge: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w200,
        color: ThemeColors.blackColor,
        height: 1.5,
      ),
      bodyMedium: const TextStyle(
        fontFamily: poppins,
        fontSize: Dimens.marginTwelve,
        fontWeight: FontWeight.w300,
        color: ThemeColors.grayDark,
      ),
      labelSmall: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: ThemeColors.blackColor,
        height: 1.5,
        letterSpacing: 0.6,
      ),
      labelMedium: const TextStyle(
        fontSize: Dimens.marginTwelve,
        fontWeight: FontWeight.w300,
        color: ThemeColors.grayDark,
      ),
      displaySmall: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w300,
        color: ThemeColors.blackColor,
        height: 1.5,
        letterSpacing: 0.6,
      ),
      displayMedium: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w300,
        color: ThemeColors.blackColor,
        height: 1.5,
        letterSpacing: 0.6,
      ),
      displayLarge: const TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w500,
        color: ThemeColors.orangeColor,
      ),
      titleMedium: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: ThemeColors.orangeColor,
      ),
    ),
  );
}
