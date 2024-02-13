import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../services/swap_service/swap_service.dart';
import '../../../services/theme_service.dart';
import '../../../theme/custom_theme.dart';
import '../controller/swap_controller.dart';
import 'swap_card.dart';

class SwapWidget extends GetView<SwapController> {
  const SwapWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final FondueSwapTheme theme = Get.put(ThemeService()).fondueSwapTheme;
    final SwapService swapService = Get.find<SwapService>();
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Obx(
              () {
                return SwapCard(
                  title: 'Pay',
                  value: '0.0',
                  buttonLable: (swapService.tokenX.value == null)
                      ? 'Select Token'
                      : swapService.tokenX.value!.name,
                  onPressed: controller.selectTokenX,
                );
              },
            ),
            const SizedBox(
              height: 16,
            ),
            Obx(
              () {
                return SwapCard(
                  title: 'Receive',
                  value: '0.0',
                  buttonLable: (swapService.tokenY.value == null)
                      ? 'Select Token'
                      : swapService.tokenY.value!.name,
                  onPressed: controller.selectTokenY,
                );
              },
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
