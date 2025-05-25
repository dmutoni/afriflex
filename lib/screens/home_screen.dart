import 'package:afriflex/enums/route_configurations/afriflex_routes.dart';
import 'package:afriflex/providers/auth_provider.dart';
import 'package:afriflex/values/colors.dart';
import 'package:afriflex/values/dimens.dart';
import 'package:afriflex/widgets/templates/generic_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    
    return GenericTemplate(
      isScrollable: true,
      title: '',
      actionsContentOverride: Image.asset(
        'assets/images/home_page/profile.png',
      ),
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimens.marginBig),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            Text(
              'Hi, ${authState.user?.lastName}',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width:
                  double.infinity, // Ensures the Stack takes full screen width
              child: Stack(
                clipBehavior: Clip.none, // Allows the card to overflow outside
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 32),
                    height: MediaQuery.of(context).size.height * 0.17,
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                      color: ThemeColors.grayLight,
                      borderRadius: BorderRadius.circular(48),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 8,
                      children: [
                        Row(
                          spacing: 8,
                          children: [
                            Text(
                              'Balance',
                              style: TextStyle(
                                  fontSize: 18, color: Colors.black54),
                            ),
                            Icon(
                              Icons.visibility_off,
                              color: Colors.black54,
                              size: 18,
                            ),
                          ],
                        ),
                        Text(
                          'XAF 12,000',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: -20, // Adjust overlap
                    bottom: 10,
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Container(
                        width: 165,
                        height: 125,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              ThemeColors.blackColor,
                              ThemeColors.orangeColor
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'PMG Pay',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(fontSize: 14),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'PREMIUM ACCOUNT',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      fontSize: 8,
                                      color: Colors.white70,
                                    ),
                              ),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '5789 **** **** 2847',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                          fontSize: 8,
                                        ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Card holder',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                              fontSize: 8,
                                              color: Colors.white54,
                                            ),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.2,
                                        child: Text(
                                          'Jacques Kagabo',
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              ?.copyWith(
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        'Expire date',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                              fontSize: 8,
                                              color: Colors.white54,
                                            ),
                                      ),
                                      Text(
                                        '06/28',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FeatureItem(
                  icon: Icons.qr_code_scanner_outlined,
                  label: 'Digital Tontine',
                  color: Colors.orange,
                  onPressed: () => context.pushNamed(
                    AfriflexRoutes.digitalTontineRoute,
                  ),
                ),
                FeatureItem(
                  icon: Icons.send_to_mobile_outlined,
                  label: 'Send Money',
                  color: Colors.orange,
                  onPressed: () {
                    context.pushNamed(
                      AfriflexRoutes.sendMoneyRoute,
                    );
                  },
                ),
                const FeatureItem(
                  icon: Icons.account_balance_wallet_outlined,
                  label: 'Add Money',
                  color: Colors.orange,
                ),
                const FeatureItem(
                  icon: Icons.keyboard_arrow_down_rounded,
                  label: 'View more',
                  color: Colors.grey,
                  isViewMore: true,
                ),
              ],
            ),
            const SectionHeader(title: "Send money"),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.11,
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: const <Widget>[
                  ContactItem(initials: "JM", name: "Jhon"),
                  ContactItem(initials: "AN", name: "Ann"),
                  ContactItem(initials: "MT", name: "Mike"),
                  ContactItem(initials: "MI", name: "Mia"),
                  ContactItem(initials: "MI", name: "Mia"),
                ],
              ),
            ),
            const TransactionTable(),
          ],
        ),
      ),
      backgroundColor: ThemeColors.whiteColor,
      showDrawer: true,
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
          title: 'Outgoing Transactions',
        ),
        TransactionSection(
          columns: ["Receiver", "Type", "Date", "Amount"],
          rows: [
            ["Ikimina", "Tontine", "13 May", "XAF75.67"],
            ["Jhon", "Transfer", "19 May", "XAF15.03"],
          ],
        ),
        SectionHeader(
          title: 'Incoming Transactions',
        ),
        TransactionSection(
          columns: ["Sender", "Type", "Date", "Amount"],
          rows: [
            ["Mia", "Transfer", "13 May", "XAF75.67"],
            ["Jhon", "Transfer", "19 May", "XAF15.03"],
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
