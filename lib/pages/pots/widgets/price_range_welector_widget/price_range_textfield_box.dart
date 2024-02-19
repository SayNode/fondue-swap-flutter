import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../services/theme_service.dart';
import '../../../../theme/constants.dart';
import '../../../../theme/custom_theme.dart';
import 'price_increase_decrease_button.dart';

class PriceRangeTextFieldBox extends StatelessWidget {
  const PriceRangeTextFieldBox({
    required this.increase,
    required this.decrease,
    required this.lable,
    required this.controller,
    super.key,
  });
  final Function increase;
  final Function decrease;
  final String lable;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final FondueSwapTheme theme = Get.put(ThemeService()).fondueSwapTheme;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.graphite,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        children: <Widget>[
          Text(
            lable,
            style: FondueSwapConstants.fromColor(
              theme.mistyLavender,
            ).kRoboto14,
          ),
          TextField(
            controller: controller,
            textAlign: TextAlign.center,
            style: FondueSwapConstants.fromColor(
              theme.mistyLavender,
            ).kRoboto22,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: '0.0',
              hintStyle: FondueSwapConstants.fromColor(
                theme.mistyLavender,
              ).kRoboto22,
              suffixIconConstraints: const BoxConstraints(
                minHeight: 24,
                minWidth: 24,
              ),
              prefixIconConstraints: const BoxConstraints(
                minHeight: 24,
                minWidth: 24,
              ),
              prefixIcon: PriceIncreaseDecreaseButton(
                onPressed: decrease,
                isIncrease: false,
              ),
              suffixIcon: PriceIncreaseDecreaseButton(
                onPressed: increase,
                isIncrease: true,
              ),
            ),
          ),
          Text(
            'per',
            style: FondueSwapConstants.fromColor(theme.mistyLavender).kRoboto14,
          ),
        ],
      ),
    );
  }
}
