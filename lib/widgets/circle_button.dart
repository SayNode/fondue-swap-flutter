import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/theme_service.dart';
import '../theme/custom_theme.dart';

class CircleButton extends StatelessWidget {
  const CircleButton({
    required this.icon,
    super.key,
    this.iconColor,
    this.backgroundColor,
    this.onPressed,
  });
  final String icon;
  final Color? iconColor;
  final Color? backgroundColor;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final FondueSwapTheme theme = Get.put(ThemeService()).fondueSwapTheme;
    Color buttonColor = theme.goldenSunset;
    Color iconColor = theme.mistyLavender;
    if (backgroundColor != null) {
      buttonColor = backgroundColor!;
    }

    if (this.iconColor != null) {
      iconColor = this.iconColor!;
    }

    return RawMaterialButton(
      onPressed: onPressed,
      elevation: 0,
      fillColor: buttonColor,
      shape: const CircleBorder(),
      child: Padding(
        padding: const EdgeInsets.all(17),
        child: Image.asset(
          icon,
          height: 15,
          width: 15,
          color: iconColor,
        ),
      ),
    );
  }
}
