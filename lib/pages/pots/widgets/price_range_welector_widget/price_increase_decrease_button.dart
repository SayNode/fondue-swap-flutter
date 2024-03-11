import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../services/new_position_service.dart';
import '../../../../services/theme_service.dart';
import '../../../../theme/custom_theme.dart';

class PriceIncreaseDecreaseButton extends StatelessWidget {
  const PriceIncreaseDecreaseButton({
    required this.onPressed,
    required this.isIncrease,
    super.key,
  });

  final void Function()? onPressed;
  final bool isIncrease;

  @override
  Widget build(BuildContext context) {
    final FondueSwapTheme theme = Get.put(ThemeService()).fondueSwapTheme;
    final NewPositionService newPositionService =
        Get.find<NewPositionService>();
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(124, 141, 176, 0.11),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Obx(
        () {
          return IconButton(
            //remove padding and margin
            padding: EdgeInsets.zero,
            onPressed: (newPositionService.canSelectPRiceRange.value &&
                    !newPositionService.fetchingPoolData.value)
                ? onPressed
                : null,
            icon: Icon(
              isIncrease ? Icons.add : Icons.remove,
              color: theme.mistyLavender,
            ),
          );
        },
      ),
    );
  }
}
