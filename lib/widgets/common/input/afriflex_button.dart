import 'package:afriflex/enums/widget_configurations/app_button_variant.dart';
import 'package:afriflex/values/dimens.dart';
import 'package:afriflex/values/duration_values.dart';
import 'package:afriflex/widgets/app_inkwell.dart';
import 'package:flutter/material.dart';

class AfriflexButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final VoidCallback? disabledOnTap;
  final AfriflexButtonVariant variant;
  final bool isLoading;
  final bool isEnabled;
  final bool isVisible;
  final Widget? trailingWidget;
  final bool? awaitOnTap;
  final Widget? leadingWidget;
  final double? height;
  final double? width;
  final Widget? actionIcon;
  final TextStyle? textStyle;

  const AfriflexButton({
    super.key,
    required this.title,
    required this.onTap,
    this.disabledOnTap,
    this.variant = AfriflexButtonVariant.dark,
    this.isLoading = false,
    this.isEnabled = true,
    this.isVisible = true,
    this.trailingWidget,
    this.awaitOnTap,
    this.leadingWidget,
    this.height,
    this.width,
    this.actionIcon,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    Color primaryColor = variant.textColor;
    LinearGradient backgroundColor = variant.backgroundColor;

    if (!isEnabled) {
      primaryColor = variant.disabledTextColor;
      backgroundColor = variant.disabledBackgroundColor;
    }

    return AnimatedContainer(
      duration: Durations.short2,
      decoration: BoxDecoration(
        gradient: backgroundColor,
        border: variant.border,
        borderRadius: BorderRadius.circular(
          Dimens.radiusDefault,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: AppProtectedInkWell.create(
          onTap: () async {
            if (isLoading) return;
            await Future.delayed(DurationValues.onTapDelay);
            isEnabled ? onTap.call() : disabledOnTap?.call();
          },
          awaitOnTap: awaitOnTap,
          child: AnimatedSize(
            duration: Durations.short2,
            child: Container(
              constraints: BoxConstraints(
                minHeight: isVisible ? height ?? Dimens.inputHeight : 0,
                maxHeight:
                    isLoading ? height ?? Dimens.inputHeight : double.infinity,
              ),
              width: width ?? double.infinity,
              height: height ?? Dimens.inputHeight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildContent(primaryColor, primaryColor, context),
                  if (trailingWidget != null)
                    Padding(
                      padding:
                          const EdgeInsets.only(right: Dimens.marginMedium),
                      child: trailingWidget ?? Container(),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(
    Color backgroundColor,
    Color primaryColor,
    BuildContext context,
  ) =>
      isLoading
          ? AspectRatio(
              aspectRatio: 1.0,
              child: Padding(
                padding: const EdgeInsets.all(Dimens.marginEigtheen),
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(primaryColor),
                  backgroundColor: backgroundColor,
                ),
              ),
            )
          : Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  leadingWidget ?? const SizedBox.shrink(),
                  if (leadingWidget != null && title.isNotEmpty)
                    const SizedBox(
                      width: Dimens.marginSmall,
                    ),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: primaryColor,
                        ),
                  ),
                  if (actionIcon != null) actionIcon ?? const SizedBox.shrink(),
                ],
              ),
            );
}
