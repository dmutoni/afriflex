enum AfriflexTopSnackbarLevel { warning, alert }

extension AfriflexTopSnackbarLevelExtension on String {
  AfriflexTopSnackbarLevel get asSnackbarThreshold {
    switch (this) {
      case 'warning':
        return AfriflexTopSnackbarLevel.warning;
      default:
        return AfriflexTopSnackbarLevel.alert;
    }
  }
}
