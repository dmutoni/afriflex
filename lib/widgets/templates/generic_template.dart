import 'package:afriflex/enums/route_configurations/afriflex_routes.dart';
import 'package:afriflex/providers/auth_provider.dart';
import 'package:afriflex/theme/styles.dart';
import 'package:afriflex/values/colors.dart';
import 'package:afriflex/values/dimens.dart';
import 'package:afriflex/values/duration_values.dart';
import 'package:afriflex/widgets/common/visual/generic_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class GenericTemplate extends ConsumerWidget {
  final String title;
  final Widget content;
  final List<Widget>? actions;
  final Color backgroundColor;
  final bool isLoading;
  final bool isScrollable;
  final bool showDrawer;
  final Widget? actionsContentOverride;

  const GenericTemplate({
    super.key,
    required this.title,
    required this.content,
    required this.backgroundColor,
    this.actions,
    this.isLoading = false,
    this.isScrollable = true,
    this.showDrawer = false,
    this.actionsContentOverride,
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

    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      extendBodyBehindAppBar: true,
      appBar: GenericHeader(
        titleText: title,
        leadingContentOverride: showDrawer
            ? IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  scaffoldKey.currentState?.openDrawer();
                },
              )
            : null,
        actionsContentOverride: actionsContentOverride,
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
      drawer: showDrawer
          ? ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(70),
                bottomRight: Radius.circular(70),
              ),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.7,
                decoration: const BoxDecoration(
                  color: ThemeColors.whiteColor,
                  gradient: ThemeColors.drawerGradient,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: Dimens.marginDefault,
                  vertical: 60,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 20,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.close,
                        color: ThemeColors.whiteColor,
                        size: 30,
                      ),
                      onPressed: () {
                        scaffoldKey.currentState?.openEndDrawer();
                      },
                    ),
                    const Row(
                      spacing: 12,
                      children: [
                        Icon(
                          Icons.home_outlined,
                          color: ThemeColors.whiteColor,
                          size: 30,
                        ),
                        Text('Home', style: Styles.drawerTextStyle),
                      ],
                    ),
                    const Row(
                      spacing: 12,
                      children: [
                        Icon(
                          Icons.real_estate_agent_sharp,
                          color: ThemeColors.whiteColor,
                          size: 30,
                        ),
                        Text('Digital tontine', style: Styles.drawerTextStyle),
                      ],
                    ),
                    const Row(
                      spacing: 12,
                      children: [
                        Icon(
                          Icons.area_chart_outlined,
                          color: ThemeColors.whiteColor,
                          size: 30,
                        ),
                        Text('Wallet', style: Styles.drawerTextStyle),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        context.pushNamed(
                          AfriflexRoutes.sendMoneyRoute,
                        );
                      },
                      child: const Row(
                        spacing: 12,
                        children: [
                          Icon(
                            Icons.wallet,
                            color: ThemeColors.whiteColor,
                            size: 30,
                          ),
                          Text('Send Money', style: Styles.drawerTextStyle),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 300,
                    ),
                    const Row(
                      spacing: 12,
                      children: [
                        Icon(
                          Icons.support_agent_outlined,
                          color: ThemeColors.whiteColor,
                          size: 30,
                        ),
                        Text('Customer Support', style: Styles.drawerTextStyle),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        ref.read(authProvider.notifier).signOut();
                        context.pushNamed(AfriflexRoutes.loginRoute);
                      },
                      child: const Row(
                        spacing: 12,
                        children: [
                          Icon(
                            Icons.logout_outlined,
                            color: ThemeColors.whiteColor,
                            size: 30,
                          ),
                          Text('Logout', style: Styles.drawerTextStyle),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          : null,
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
