import 'package:afriflex/values/colors.dart';
import 'package:afriflex/values/dimens.dart';
import 'package:afriflex/widgets/common/gradient_box_border.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class OnboardingTontineCarousel extends StatefulWidget {
  const OnboardingTontineCarousel({super.key});

  @override
  State<OnboardingTontineCarousel> createState() =>
      _OnboardingTontineCarouselState();
}

class _OnboardingTontineCarouselState extends State<OnboardingTontineCarousel> {
  int _currentIndex = 0; // Keeps track of the active carousel card

  @override
  Widget build(BuildContext context) {
    final items = [
      CarouselItem(icon: Icons.qr_code, label: "Digital Tontine"),
      CarouselItem(icon: Icons.send, label: "Send Money"),
      CarouselItem(icon: Icons.wallet, label: "Wallet"),
    ];

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CarouselSlider(
          items: items.map((item) => _buildCarouselCard(item)).toList(),
          options: CarouselOptions(
            height: 100,
            enlargeCenterPage: true,
            viewportFraction: 0.4,
            enableInfiniteScroll: false,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index; // Update the current index
              });
            },
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            items.length,
            (index) => _buildIndicator(isActive: _currentIndex == index),
          ),
        ),
      ],
    );
  }

  Widget _buildCarouselCard(CarouselItem item) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: Container(
        width: 150,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimens.marginSmall),
          border: const GradientBoxBorder(
            gradient: ThemeColors.primaryColor,
            width: 1.5,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(item.icon, size: 30, color: Colors.grey.shade700),
            Text(
              item.label,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIndicator({required bool isActive}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: isActive ? 12 : 8,
      height: isActive ? 12 : 8,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? const Color(0xFFF59421) : Colors.grey.shade400,
      ),
    );
  }
}

class CarouselItem {
  final IconData icon;
  final String label;

  CarouselItem({required this.icon, required this.label});
}
