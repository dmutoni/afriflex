import 'package:afriflex/enums/route_configurations/afriflex_routes.dart';
import 'package:afriflex/providers/account_provider.dart';
import 'package:afriflex/providers/auth_provider.dart';
import 'package:afriflex/providers/tontines_provider.dart';
import 'package:afriflex/values/colors.dart';
import 'package:afriflex/values/dimens.dart';
import 'package:afriflex/widgets/templates/generic_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class DigitalTontineScreen extends ConsumerStatefulWidget {
  const DigitalTontineScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DigitalTontineScreenState();
}

class _DigitalTontineScreenState extends ConsumerState<DigitalTontineScreen> {
  bool _isAmountVisible = true;

  void _toggleAmountVisibility() {
    setState(() {
      _isAmountVisible = !_isAmountVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final userAccounts = ref.watch(userAccountsProvider);
    final activeTontines = ref.watch(activeTontinesProvider(()));
    
    return GenericTemplate(
      title: '',
      actionsContentOverride: CircleAvatar(
        radius: 32,
        backgroundColor: Colors.grey.shade300,
        child: Text(
          authState.user?.firstName.substring(0, 2).toUpperCase() ?? '',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
      showDrawer: true,
      isScrollable: true,
      onRefresh: () async{
        ref.invalidate(activeTontinesProvider(()));
        ref.invalidate(userAccountsProvider);
      },
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimens.marginBig),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              height: MediaQuery.of(context).size.height * 0.18,
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                color: ThemeColors.grayLight,
                borderRadius: BorderRadius.circular(48),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8,
                children: [
                  Row(
                    spacing: 8,
                    children: [
                      const Text(
                        'Balance',
                        style: TextStyle(fontSize: 18, color: Colors.black54),
                      ),
                      InkWell(
                        onTap: _toggleAmountVisibility,
                        child: Icon(
                          _isAmountVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.black54,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                  ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: userAccounts.accounts.length,
                          itemBuilder: (context, index) {
                            final account = userAccounts.accounts[index];
                            return SizedBox(
                              width: 140,
                              child: Text(
                                _isAmountVisible
                                    ? '${account.currencyCode} ${account.balance}'
                                    : '${account.currencyCode} ----',
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            );
                          },
                        ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FeatureItem(
                  icon: Icons.group_add_outlined,
                  label: 'Create tontine',
                  color: Colors.orange,
                  onPressed: () => context.pushNamed(
                    AfriflexRoutes.createTontineRoute,
                  ),
                ),
                FeatureItem(
                  icon: Icons.insights,
                  label: 'Insights',
                  color: Colors.orange,
                  onPressed: () {
                    context.pushNamed(
                      AfriflexRoutes.sendMoneyRoute,
                    );
                  },
                ),
                const FeatureItem(
                  icon: Icons.keyboard_arrow_down_rounded,
                  label: 'View more',
                  color: Colors.grey,
                  isViewMore: true,
                ),
              ],
            ),
            const SectionHeader(title: "Active tontine"),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.14,
              child: activeTontines.when(
                data: (tontines) {
                  if (tontines.content == null || tontines.content!.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 16.0, left: 20, right: 20),
                      child: Text(
                        "No active tontines available",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontStyle: FontStyle.italic,
                          color: Colors.grey,
                        ),
                      ),
                    );
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: tontines.content!.length,
                    itemBuilder: (context, index) {
                      final tontine = tontines.content![index];
                      return GestureDetector(
                        onTap: () {},
                        child: ContactItem(
                          initials: tontine.name[0],
                          name: tontine.name,
                        ),
                      );
                    },
                  );
                },
                error: (error, stack) => Center(
                  child: Text('Error loading tontines: $error'),
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
              ),
            ),
            const TransactionTable(),
          ],
        ),
      ),
      backgroundColor: ThemeColors.whiteColor,
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;
  const SectionHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        const Text(
          "View all >",
          style: TextStyle(color: Colors.grey, fontSize: 14),
        ),
      ],
    );
  }
}

class FeatureItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback? onPressed;
  final bool isViewMore;

  const FeatureItem({
    super.key,
    required this.icon,
    required this.label,
    required this.color,
    this.onPressed,
    this.isViewMore = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.2,
        height: MediaQuery.of(context).size.height * 0.11,
        child: Column(
          spacing: 8,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.05,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: isViewMore
                    ? BorderRadius.circular(Dimens.radiusCircular)
                    : null,
                border:
                    isViewMore ? Border.all(color: Colors.grey.shade300) : null,
              ),
              child: Icon(icon, color: color, size: 32),
            ),
            Text(
              label,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
              overflow: TextOverflow.visible,
            ),
          ],
        ),
      ),
    );
  }
}

class ContactItem extends StatelessWidget {
  final String initials;
  final String name;

  const ContactItem({
    super.key,
    required this.initials,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.18,
      height: MediaQuery.of(context).size.height * 0.11,
      child: Column(
        spacing: 8,
        children: [
          CircleAvatar(
            radius: 32,
            backgroundColor: Colors.grey.shade300,
            child: Text(
              initials,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Text(
            name,
            style: const TextStyle(fontSize: 12, color: Colors.black),
          ),
        ],
      ),
    );
  }
}

// Transaction Item Widget
class TransactionItem extends StatelessWidget {
  final String title;
  final String type;
  final String date;
  final String amount;

  const TransactionItem({
    super.key,
    required this.title,
    required this.type,
    required this.date,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              const SizedBox(height: 4),
              Text(
                type,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                date,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(height: 4),
              Text(
                amount,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TransactionTable extends StatelessWidget {
  const TransactionTable({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        SectionHeader(
          title: 'Upcoming transactions',
        ),
        TransactionSection(
          columns: [
            "Tontine",
            "Date",
            "Amount",
          ],
          rows: [
            [
              "Ikimina 1",
              "13 May",
              "XAF 75.67",
            ],
            [
              "Ikimina 1",
              "13 May",
              "XAF 752.67",
            ],
          ],
        ),
        SectionHeader(
          title: 'Incoming Transactions',
        ),
        TransactionSection(
          columns: [
            "Tontine",
            "Date",
            "Amount",
          ],
          rows: [
            [
              "Ikimina 1",
              "13 May",
              "XAF 75.67",
            ],
            [
              "Ikimina 1",
              "13 May",
              "XAF 752.67",
            ],
          ],
        ),
      ],
    );
  }
}

class TransactionSection extends StatelessWidget {
  final List<String> columns;
  final List<List<String>> rows;

  const TransactionSection({
    super.key,
    required this.columns,
    required this.rows,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (rows.isEmpty)
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                "No transactions available",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontStyle: FontStyle.italic,
                      color: Colors.grey,
                    ),
              ),
            ),
          )
        else
          Table(
            children: [
              TableRow(
                children: columns
                    .map(
                      (column) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          column,
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontSize: Dimens.marginFourteen,
                                  ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                    .toList(),
              ),
              ...rows.map(
                (row) => TableRow(
                  children: row
                      .map(
                        (cell) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            cell,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
      ],
    );
  }
}
