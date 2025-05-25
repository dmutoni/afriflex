import 'package:afriflex/enums/route_configurations/afriflex_routes.dart';
import 'package:afriflex/enums/widget_configurations/app_button_variant.dart';
import 'package:afriflex/values/colors.dart';
import 'package:afriflex/values/dimens.dart';
import 'package:afriflex/widgets/common/input/afriflex_button.dart';
import 'package:afriflex/widgets/templates/generic_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ConfirmPaymentScreen extends ConsumerStatefulWidget {
  const ConfirmPaymentScreen({super.key});

  @override
  ConsumerState<ConfirmPaymentScreen> createState() =>
      _ConfirmPaymentScreenState();
}

class _ConfirmPaymentScreenState extends ConsumerState<ConfirmPaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return GenericTemplate(
      title: 'Payment details',
      content: Container(
        margin: const EdgeInsets.all(
          Dimens.marginDefault,
        ),
        padding: const EdgeInsets.only(
          top: Dimens.marginDefault,
          bottom: 30,
        ),
        // height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: ThemeColors.primaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Image.asset(
              'assets/images/home_page/successful_transaction.png',
              height: 100,
              width: 100,
            ),
            Text(
              'Transaction Successful,',
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    color: ThemeColors.whiteColor,
                    fontSize: 18,
                  ),
            ),
            const Text('Thank you!'),
            const SizedBox(
              height: 100,
            ),
            AfriflexButton(
              title: 'Done',
              onTap: () {
                context.pushNamed(AfriflexRoutes.homeRoute);
              },
              variant: AfriflexButtonVariant.black,
              width: 100,
            )
          ],
        ),
      ),
      backgroundColor: ThemeColors.whiteColor,
    );
  }
}
