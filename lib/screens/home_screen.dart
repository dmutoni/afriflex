import 'package:afriflex/enums/route_configurations/afriflex_routes.dart';
import 'package:afriflex/helpers/formatting_helper.dart';
import 'package:afriflex/providers/account_provider.dart';
import 'package:afriflex/providers/auth_provider.dart';
import 'package:afriflex/providers/contacts_provider.dart';
import 'package:afriflex/providers/transactions_provider.dart';
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
  bool _isAmountVisible = true;

  void _toggleAmountVisibility() {
    setState(() {
      _isAmountVisible = !_isAmountVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final userAccounts = ref.watch(userAccountsProvider(()));
    final userContacts = ref.watch(userContactsProvider(()));

    return GenericTemplate(
      onRefresh: () async {
        ref.invalidate(userContactsProvider);
        ref.invalidate(userAccountsProvider);
      },
      isScrollable: true,
      title: '',
      actionsContentOverride: Image.asset(
        'assets/images/home_page/profile.png',
      ),
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimens.marginMedium),
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 8,
                      children: [
                        Row(
                          spacing: 8,
                          children: [
                            const Text(
                              'Balance',
                              style: TextStyle(
                                  fontSize: 18, color: Colors.black54),
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
                        userAccounts.when(
                          data: (accounts) => ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: accounts.length,
                            itemBuilder: (context, index) {
                              final account = accounts[index];
                              return SizedBox(
                                width: 140,
                                child: Text(
                                  _isAmountVisible
                                      ? '${account.currencyCode} ${formatNumberWithSuffix(account.balance, max: 10000, decimalPlaces: 2)}'
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
                          loading: () => const Center(child: CircularProgressIndicator()),
                          error: (error, stack) => const Text(''),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: -8,
                    bottom: 10,
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.45, // Dynamic width
                        height: 125,
                        clipBehavior: Clip.none,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [ThemeColors.blackColor, ThemeColors.orangeColor],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'PMG Pay',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 14),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'PREMIUM ACCOUNT',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      fontSize: 8,
                                      color: Colors.white70,
                                    ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                '5789 **** **** 2847',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      fontSize: 8,
                                    ),
                              ),
                              const SizedBox(height: 6),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Card holder',
                                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                fontSize: 8,
                                                color: Colors.white54,
                                              ),
                                        ),
                                        Text(
                                          'Jacques Kagabo',
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          'Expire date',
                                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                fontSize: 8,
                                                color: Colors.white54,
                                              ),
                                        ),
                                        Text(
                                          '06/28',
                                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                      ],
                                    ),
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
            Wrap(
              spacing: 2, // Horizontal spacing between items
              runSpacing: 8, // Vertical spacing between lines
              alignment: WrapAlignment.spaceBetween,
              children: [
                FeatureItem(
                  icon: Icons.qr_code_scanner_outlined,
                  label: 'Digital Tontine',
                  color: Colors.orange,
                  onPressed: () => context.pushNamed(AfriflexRoutes.digitalTontineRoute),
                ),
                FeatureItem(
                  icon: Icons.send_to_mobile_outlined,
                  label: 'Send Money',
                  color: Colors.orange,
                  onPressed: () => context.pushNamed(AfriflexRoutes.sendMoneyRoute),
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
            userContacts.when(
              data: (contacts) {
                if (contacts.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: Text(
                        "No contacts available",
                        style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey),
                      ),
                    ),
                  );
                }
                return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.13,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: contacts.length,
                    itemBuilder: (context, index) {
                      final contact = contacts[index];
                      return ContactItem(
                        initials: contact.contactName.substring(0, 2).toUpperCase(),
                        name: contact.contactName,
                      );
                    },
                  ),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Text('$error', style: const TextStyle(color: Colors.red)),
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
              overflow: TextOverflow.ellipsis, // Changed from TextOverflow.visible
              maxLines: 2,
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
            overflow: TextOverflow.ellipsis, // Changed from TextOverflow.visible
            maxLines: 2, // Ensures the text does not overflow
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
                  color: Colors.orange,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TransactionTable extends ConsumerStatefulWidget {
  const TransactionTable({super.key});

  @override
  ConsumerState<TransactionTable> createState() => _TransactionTableState();
}

class _TransactionTableState extends ConsumerState<TransactionTable> {
  String? _selectedAccountNumber;

  @override
  Widget build(BuildContext context) {
    // final accountsAsync = ref.watch(userAccountsProvider(()));
    // final incomingTransactionsAsync = ref.watch(filterTransactionsProvider((
    //   page: 1,
    //   limit: 5,
    //   areIncomingTransactions: true,
    //   accountNumber: _selectedAccountNumber,
    //   category: null,
    //   transactionType: null,
    //   status: null,
    //   startDate: null,
    //   endDate: null,
    // )));
    // final outgoingTransactionsAsync = ref.watch(filterTransactionsProvider((
    //   page: 1,
    //   limit: 5,
    //   areIncomingTransactions: false,
    //   accountNumber: _selectedAccountNumber,
    //   category: null,
    //   transactionType: null,
    //   status: null,
    //   startDate: null,
    //   endDate: null,
    // )));

    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // accountsAsync.when(
        //   data: (accounts) {
        //     return Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //       crossAxisAlignment: CrossAxisAlignment.center,
        //       children: [
        //         const Text(
        //           'Select Account',
        //           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        //         ),
        //         DropdownButton<String?>(
        //           value: _selectedAccountNumber,
        //           hint: const Text(''),
        //           isExpanded: true,
        //           items: accounts.map((account) {
        //             return DropdownMenuItem<String?>(
        //               value: account.accountNumber,
        //               child: Text(account.accountNumber),
        //             );
        //           }).toList(),
        //           onChanged: (value) {
        //             setState(() {
        //               _selectedAccountNumber = value;
        //             });
        //           },
        //         ),
        //       ],
        //     );
        //   },
        //   loading: () => const SizedBox.shrink(),
        //   error: (error, stack) => Center(
        //     child: Column(
        //       children: [
        //         Text('Error loading accounts: $error'),
        //         TextButton(
        //           onPressed: () => ref.invalidate(userAccountsProvider),
        //           child: const Text('Retry'),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
        // const SectionHeader(title: 'Outgoing Transactions'),
        // outgoingTransactionsAsync != null
        //     ? outgoingTransactionsAsync.when(
        //         data: (page) {
        //           final transactions = page.content ?? [];
        //           if (transactions.isEmpty) {
        //             return const Center(child: Text('No outgoing transactions'));
        //           }
        //           return TransactionSection(
        //             columns: const ["Receiver", "Type", "Date", "Amount"],
        //             rows: transactions.map((t) => [
        //               t.description,
        //               t.transactionType.name,
        //               t.createdAt.toIso8601String(),
        //               formatNumberWithSuffix(
        //                 t.amount,
        //                 max: 1000,
        //                 prefix: t.currencyCode,
        //                 decimalPlaces: 2,
        //               ),
        //             ]).toList(),
        //           );
        //         },
        //         loading: () => const Center(child: CircularProgressIndicator()),
        //         error: (error, stack) => Center(
        //           child: Column(
        //             children: [
        //               Text('Error: $error'),
        //               TextButton(
        //                 onPressed: () => ref.invalidate(filterTransactionsProvider),
        //                 child: const Text('Retry'),
        //               ),
        //             ],
        //           ),
        //         ),
        //       )
        //     : const Center(child: Text('Select an account to view transactions')),
        // const SectionHeader(title: 'Incoming Transactions'),
        // incomingTransactionsAsync != null
        //     ? incomingTransactionsAsync.when(
        //         data: (page) {
        //           final transactions = page.content ?? [];
        //           if (transactions.isEmpty) {
        //             return const Center(child: Text('No incoming transactions'));
        //           }
        //           return TransactionSection(
        //             columns: const ["Sender", "Type", "Date", "Amount"],
        //             rows: transactions.map((t) => [
        //               t.description,
        //               t.transactionType.name,
        //               t.createdAt.toIso8601String(),
        //               formatNumberWithSuffix(
        //                 t.amount,
        //                 max: 1000,
        //                 prefix: t.currencyCode,
        //                 decimalPlaces: 2,
        //               ),
        //             ]).toList(),
        //           );
        //         },
        //         loading: () => const Center(child: CircularProgressIndicator()),
        //         error: (error, stack) => Center(
        //           child: Column(
        //             children: [
        //               Text('Error: $error'),
        //               TextButton(
        //                 onPressed: () => ref.invalidate(filterTransactionsProvider),
        //                 child: const Text('Retry'),
        //               ),
        //             ],
        //           ),
        //         ),
        //       )
        //     : const Center(child: Text('Select an account to view transactions')),
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
