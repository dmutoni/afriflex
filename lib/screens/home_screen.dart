import 'package:afriflex/values/colors.dart';
import 'package:afriflex/values/dimens.dart';
import 'package:afriflex/widgets/templates/generic_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return GenericTemplate(
      isScrollable: true,
      title: '',
      actionsContentOverride: Image.asset(
        ''
        'assets/images/home_page/profile.png',
      ),
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimens.marginBig),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hi, Jacques',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width:
                  double.infinity, // Ensures the Stack takes full screen width
              child: Stack(
                clipBehavior: Clip.none, // Allows the card to overflow outside
                children: [
                  // Balance Container
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
              children: const [
                FeatureItem(
                    icon: Icons.qr_code,
                    label: 'Digital Tontine',
                    color: Colors.orange),
                FeatureItem(
                    icon: Icons.send,
                    label: 'Send Money',
                    color: Colors.orange),
                FeatureItem(
                    icon: Icons.account_balance_wallet,
                    label: 'Add Money',
                    color: Colors.orange),
                FeatureItem(
                    icon: Icons.more_horiz,
                    label: 'View more',
                    color: Colors.grey),
              ],
            ),
            const SectionHeader(title: "Send money"),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                ContactItem(initials: "JM", name: "Jhon"),
                ContactItem(initials: "AN", name: "Ann"),
                ContactItem(initials: "MT", name: "Mike"),
                ContactItem(initials: "MI", name: "Mia"),
              ],
            ),
            const SizedBox(height: 24),

            // Outgoing Transactions
            const SectionHeader(title: "Outgoing Transactions"),
            const TransactionItem(
              title: "Ikimina",
              type: "Tontine",
              date: "13 May",
              amount: "XAF75.67",
            ),
            const TransactionItem(
              title: "Jhon",
              type: "Transfer",
              date: "19 May",
              amount: "XAF15.03",
            ),
            const SizedBox(height: 24),

            // Incoming Transactions
            const SectionHeader(title: "Incoming Transactions"),
            const TransactionItem(
              title: "Mia",
              type: "Transfer",
              date: "13 May",
              amount: "XAF75.67",
            ),
            const TransactionItem(
              title: "Jhon",
              type: "Transfer",
              date: "19 May",
              amount: "XAF15.03",
            ),
          ],
        ),
      ),
      backgroundColor: ThemeColors.whiteColor,
      showDrawer: true,
    );
  }
}

// Section Header Widget
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

// Feature Item Widget (Top Menu)
class FeatureItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const FeatureItem(
      {super.key,
      required this.icon,
      required this.label,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 32),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}

// Contact Item Widget
class ContactItem extends StatelessWidget {
  final String initials;
  final String name;

  const ContactItem({super.key, required this.initials, required this.name});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 28,
          backgroundColor: Colors.grey.shade300,
          child: Text(
            initials,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          name,
          style: const TextStyle(fontSize: 12, color: Colors.black),
        ),
      ],
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
