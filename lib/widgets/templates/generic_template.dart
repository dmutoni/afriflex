import 'package:afriflex/values/dimens.dart';
import 'package:afriflex/values/duration_values.dart';
import 'package:afriflex/widgets/common/visual/generic_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GenericTemplate extends ConsumerWidget {
  final String title;
  final Widget content;
  final List<Widget>? actions;
  final Color backgroundColor;
  final bool isLoading;
  final bool isScrollable;

  const GenericTemplate({
    super.key,
    required this.title,
    required this.content,
    required this.backgroundColor,
    this.actions,
    this.isLoading = false,
    this.isScrollable = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget innerContent = AnimatedSwitcher(
      duration: DurationValues.fast,
      child: content,
    );

    Widget outerContent = SingleChildScrollView(
      child: innerContent,
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: GenericHeader(
        titleText: title,
      ),
      backgroundColor: backgroundColor,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(Dimens.radiusMedium),
                    topRight: Radius.circular(Dimens.radiusMedium),
                  ),
                ),
                child: isLoading
                    ? const Center(
                        key: ValueKey(true),
                        child: CircularProgressIndicator(),
                      )
                    : ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(Dimens.radiusMedium),
                          topRight: Radius.circular(Dimens.radiusMedium),
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              child: isScrollable ? outerContent : innerContent,
                            ),
                            if ((actions ?? []).isNotEmpty)
                              _buildActions(context),
                          ],
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActions(BuildContext context) {
    int lastItem = actions == null ? 0 : actions!.length * 2 - 1;
    List<Widget> buttons = (actions ?? [])
        .expand((a) => [a, const SizedBox(height: Dimens.marginDefault)])
        .toList()
        .sublist(0, lastItem);

    return SafeArea(
      top: false,
      bottom: (actions ?? []).isNotEmpty,
      maintainBottomViewPadding: false,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: Dimens.marginDefault,
          vertical: Dimens.marginDefault,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: buttons,
        ),
      ),
    );
  }
}
