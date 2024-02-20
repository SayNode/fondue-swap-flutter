import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/theme_service.dart';
import '../theme/constants.dart';
import '../theme/custom_theme.dart';
import 'fondue_button.dart';

void openPopup({
  required bool success,
  required String title,
  required String content,
}) {
  final FondueSwapTheme theme = Get.put(ThemeService()).fondueSwapTheme;
  Get.defaultDialog<Widget>(
    barrierDismissible: false,
    titleStyle: FondueSwapConstants.fromColor(theme.mistyLavender).kRoboto22,
    contentPadding: const EdgeInsets.all(30),
    titlePadding:
        const EdgeInsets.only(top: 30, left: 30, right: 30, bottom: 10),
    title: title,
    backgroundColor: theme.graphite,
    content: SizedBox(
      width: 1000,
      child: Column(
        children: <Widget>[
          Image.asset(
            success
                ? 'assets/icons/success_icon_big.png'
                : 'assets/icons/error_icon_big.png',
            width: 100,
            height: 100,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            content,
            style: FondueSwapConstants.fromColor(theme.mistyLavender).kRoboto16,
          ),
        ],
      ),
    ),
    confirm: FondueButton(text: 'Done', onTap: () => Get.back<Widget>()),
  );
}
