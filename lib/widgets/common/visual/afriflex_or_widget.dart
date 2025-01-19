import 'package:afriflex/values/colors.dart';
import 'package:flutter/material.dart';

class AfriflexOrWidget extends StatelessWidget {
  const AfriflexOrWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 14,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width / 2.5,
          child: const Divider(
            color: ThemeColors.grayLight,
          ),
        ),
        const Text('OR'),
        SizedBox(
          width: MediaQuery.of(context).size.width / 2.5,
          child: const Divider(
            color: ThemeColors.grayLight,
          ),
        ),
      ],
    );
  }
}
