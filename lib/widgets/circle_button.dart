import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/theme_service.dart';

class CircleButton extends StatelessWidget {
  final String icon;
  final Color? iconColor;
  final Color? backgroundColor;
  final void Function()? onPressed;
  const CircleButton({super.key, required this.icon, this.iconColor, this.backgroundColor, this.onPressed});

  @override
  Widget build(BuildContext context) {
    var theme = Get.put(ThemeService()).fondueSwapTheme;
    var buttonColor = theme.goldenSunset;
    var iconColor = theme.mistyLavender;
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
        padding: const EdgeInsets.all(17.0),
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
