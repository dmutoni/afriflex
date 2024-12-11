import 'package:afriflex/enums/widget_configurations/app_button_variant.dart';
import 'package:afriflex/screens/onboarding_tontine_carousel.dart';

import 'package:afriflex/values/dimens.dart';
import 'package:afriflex/widgets/common/afriflex_dropdown.dart';
import 'package:afriflex/widgets/common/input/afriflex_button.dart';
import 'package:flutter/material.dart';

import '../values/colors.dart';

class OnboardingScreen extends StatefulWidget {
  static const String routeName = '/';

  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    final items = [
      DropdownItem(
        label: 'English',
        value: 'EN',
        icon: Image.asset(
          'assets/images/onboarding/uk_flag.png',
          height: 20,
          width: 20,
        ),
      ),
      DropdownItem(
        label: 'French',
        value: 'FR',
        icon: Image.asset(
          'assets/images/onboarding/french_flag.png',
          height: 20,
          width: 20,
        ),
      ),
    ];

    return Scaffold(
      backgroundColor: ThemeColors.whiteColor,
      body: SafeArea(
        bottom: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 300),
              child: AfriflexDropdown(
                items: items,
                selectedItem: items.first,
                onChanged: (selectedItem) {
                  print('Selected: ${selectedItem.label}');
                },
              ),
            ),
            const SizedBox(height: 40),
            Text(
              'AfriFlexPay',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 20),
            Text(
              'Financial Solutions. Powered by Africa',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                'assets/images/onboarding/onboarding_person.png',
                height: 300,
                fit: BoxFit.fitWidth,
              ),
            ),
            const SizedBox(height: 20),
            const OnboardingTontineCarousel(),
            const SizedBox(height: 70),
            AfriflexButton(
              title: 'GET STARTED',
              onTap: () {},
              variant: AppButtonVariant.light,
              isEnabled: true,
              isLoading: false,
              isVisible: true,
              height: Dimens.inputHeight,
              width: 290,
              actionIcon: const Icon(
                Icons.arrow_forward,
                color: ThemeColors.whiteColor,
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
