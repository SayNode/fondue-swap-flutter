import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../services/theme_service.dart';
import '../../../theme/custom_theme.dart';
import 'swap_card.dart';

class SwapWidget extends StatelessWidget {
  const SwapWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final FondueSwapTheme theme = Get.put(ThemeService()).fondueSwapTheme;
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        const Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SwapCard(
              title: 'Pay',
              value: '0.0',
            ),
            SizedBox(
              height: 16,
            ),
            SwapCard(
              title: 'Receive',
              value: '0.0',
            ),
          ],
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            color: theme.midnightBlack,
            shape: BoxShape.circle,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: theme.goldenSunset,
                    shape: BoxShape.circle,
                  ),
                ),
                Image.asset(
                  'assets/icons/vertical_swap_icon.png',
                  height: 22,
                  width: 22,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
