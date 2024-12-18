import 'package:afriflex/values/colors.dart';
import 'package:afriflex/values/dimens.dart';
import 'package:afriflex/values/duration_values.dart';
import 'package:afriflex/widgets/common/input/protected_icon_button.dart';
import 'package:flutter/material.dart';

abstract class _Constants {
  static const leadingWidth = 48.0;
}

class GenericHeader extends AppBar {
  final String? titleText;
  final bool canPop;
  final Widget? leadingContentOverride;
  final Widget? actionsContentOverride;
  final bool isTransparent;

  GenericHeader({
    super.key,
    this.titleText,
    this.canPop = true,
    this.leadingContentOverride,
    this.actionsContentOverride,
    this.isTransparent = true,
  });

  @override
  State<GenericHeader> createState() => _GenericHeaderState();
}

class _GenericHeaderState extends State<GenericHeader> {
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Dimens.marginDefault,
        ),
        child: AppBar(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          leadingWidth: _Constants.leadingWidth,
          leading: widget.leadingContentOverride ??
              (Navigator.of(context).canPop() && widget.canPop
                  ? ProtectedIconButton.Create(
                      icon: const Icon(
                        Icons.chevron_left,
                        color: ThemeColors.blackColor,
                      ),
                      onPressed: () async {
                        await Future.delayed(DurationValues.onTapDelay);

                        Navigator.of(context).canPop();
                      },
                    )
                  : Container()),
          title: AnimatedSwitcher(
            duration: DurationValues.fast,
            child: Text(
              widget.titleText ?? '',
              style: Theme.of(context).textTheme.displaySmall,
              key: ValueKey(widget.titleText),
            ),
          ),
          actions: widget.actionsContentOverride != null
              ? [widget.actionsContentOverride!]
              : null,
        ),
      );
}
