import 'package:afriflex/enums/route_configurations/afriflex_routes.dart';
import 'package:afriflex/enums/widget_configurations/afriflex_numpad_variations.dart';
import 'package:afriflex/providers/amount_provider.dart';
import 'package:afriflex/widgets/common/afriflex_numpad.dart';
import 'package:afriflex/widgets/common/input/afriflex_button.dart';
import 'package:afriflex/widgets/templates/generic_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class EnterAmountScreen extends ConsumerStatefulWidget {
  const EnterAmountScreen({super.key});

  @override
  ConsumerState<EnterAmountScreen> createState() => _EnterAmountScreenState();
}

class _EnterAmountScreenState extends ConsumerState<EnterAmountScreen> {
  final TextEditingController _amountController = TextEditingController();

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _amountController.addListener(() {
      ref.read(amountNotifierProvider.notifier).updateAmount(
            _amountController.text,
          );
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final amount = ref.watch(amountNotifierProvider);

    return GenericTemplate(
      backgroundColor: Colors.white,
      title: 'Send Money',
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
            const CircleAvatar(
              radius: 30,
              backgroundColor: Colors.grey,
              child: Text(
                'JM',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Jhon Mamadou',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              'XAF $amount',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            AfriflexNumpad(
              controller: _amountController,
              length: 20,
              variant: AfriflexNumpadVariant.grey,
              isDarkMode: false,
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
      actions: [
        AfriflexButton(
          title: 'Confirm transfer',
          onTap: () {
            context.pushNamed(AfriflexRoutes.confirmPaymentRoute);
          },
        ),
      ],
    );
  }
}
