import 'package:afriflex/theme/styles.dart';
import 'package:afriflex/values/colors.dart';
import 'package:flutter/material.dart';

class AfriflexRequiredIndicator extends StatelessWidget {
  final String? leadingText;
  final String? trailingText;

  final Color? textColour;

  final TextStyle textStyle;

  const AfriflexRequiredIndicator({
    super.key,
    this.leadingText,
    this.trailingText,
    this.textColour,
    this.textStyle = Styles.inputLabelStyle,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      textHeightBehavior: const TextHeightBehavior(
        applyHeightToFirstAscent: false,
      ),
      text: TextSpan(
        text: leadingText,
        style: textStyle.copyWith(color: textColour),
        children: [
          const TextSpan(
            text: ' ● ',
            style: TextStyle(
              color: ThemeColors.darkGold,
              fontSize: 12.0,
            ),
          ),
          TextSpan(
            text: trailingText,
            style: textStyle.copyWith(color: textColour),
          ),
        ],
      ),
    );
  }
}
