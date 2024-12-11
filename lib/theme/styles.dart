import 'package:afriflex/values/colors.dart';
import 'package:flutter/material.dart';

abstract class Styles {
  static const _poppins = 'Poppins';

  static const TextStyle errorTextStyleRed = TextStyle(
    fontFamily: _poppins,
    fontSize: 12.0,
    fontWeight: FontWeight.w200,
    color: ThemeColors.darkRed,
  );

  static const TextStyle errorTextStyleWhite = TextStyle(
    fontFamily: _poppins,
    fontSize: 10.0,
    fontWeight: FontWeight.w400,
    height: 14.0 / 10.0,
    color: ThemeColors.whiteColor,
  );

  static const TextStyle typingStyle = TextStyle(
    fontFamily: _poppins,
    fontSize: 12.0,
    fontWeight: FontWeight.w200,
    height: 14.0 / 10.0,
    color: ThemeColors.grayDark,
  );

  static const TextStyle inputLabelStyle = TextStyle(
    fontFamily: _poppins,
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
    color: ThemeColors.blackColor,
  );
}
