import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../services/theme_service.dart';
import '../../../../theme/constants.dart';
import '../../../../theme/custom_theme.dart';

class TokenAmountTextField extends StatelessWidget {
  const TokenAmountTextField({required this.controller, super.key});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final FondueSwapTheme theme = Get.put(ThemeService()).fondueSwapTheme;
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintStyle: FondueSwapConstants.fromColor(theme.mistyLavender).kRoboto22,
        filled: true,
        fillColor: theme.graphite,
        border: InputBorder.none,
        hintText: '0.0',
        suffixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'ETH',
              style:
                  FondueSwapConstants.fromColor(theme.mistyLavender).kRoboto16,
            ),
          ],
        ),
      ),
    );
  }
}
