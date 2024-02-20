import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../models/token.dart';
import '../../../../services/theme_service.dart';
import '../../../../theme/constants.dart';
import '../../../../theme/custom_theme.dart';

class TokenAmountTextField extends StatelessWidget {
  const TokenAmountTextField({
    required this.controller,
    required this.token,
    super.key,
    this.onChanged,
  });
  final TextEditingController controller;
  final void Function(String)? onChanged;
  final Token? token;

  @override
  Widget build(BuildContext context) {
    final FondueSwapTheme theme = Get.put(ThemeService()).fondueSwapTheme;

    return TextField(
      onChanged: onChanged,
      controller: controller,
      style: FondueSwapConstants.fromColor(theme.mistyLavender).kRoboto22,
      decoration: InputDecoration(
        hintStyle: FondueSwapConstants.fromColor(theme.mistyLavender).kRoboto22,
        filled: true,
        fillColor: theme.graphite,
        border: InputBorder.none,
        hintText: '0.0',
        suffixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (token != null) Image.asset(token!.icon) else const SizedBox(),
            const SizedBox(width: 8),
            Text(
              (token != null) ? token!.abbreviation : '',
              style:
                  FondueSwapConstants.fromColor(theme.mistyLavender).kRoboto16,
            ),
            const SizedBox(
              width: 8,
            ),
          ],
        ),
      ),
    );
  }
}
