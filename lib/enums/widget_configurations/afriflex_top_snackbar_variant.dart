import 'package:afriflex/values/colors.dart';
import 'package:flutter/material.dart';

enum AfriflexTopSnackbarVariant { message, error }

extension AfriflexTopSnackbarVariantContent on AfriflexTopSnackbarVariant {
  Color get backgroundColor {
    switch (this) {
      case AfriflexTopSnackbarVariant.message:
        return ThemeColors.green;
      case AfriflexTopSnackbarVariant.error:
        return ThemeColors.red;
    }
  }
}
