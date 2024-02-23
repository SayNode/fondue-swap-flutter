import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/theme_service.dart';
import '../theme/constants.dart';
import '../theme/custom_theme.dart';

class FondueButton extends StatelessWidget {
  const FondueButton({
    required this.text,
    super.key,
    this.onTap,
    this.disabled = false,
    this.expanded = false,
    this.width,
  });
  final String text;
  final dynamic Function()? onTap;
  final bool disabled;
  final bool expanded;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final FondueSwapTheme theme = Get.put(ThemeService()).fondueSwapTheme;
    final Color color = disabled ? theme.stormyNight : theme.goldenSunset;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(256),
        ),
        backgroundColor: Colors.transparent,
        side: BorderSide(
          color: color,
        ),
      ),
      onPressed: disabled ? null : onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 24,
        ),
        child: expanded
            ? SizedBox(
                width: double.infinity,
                child: Center(
                  child: Text(
                    text.tr,
                    style: FondueSwapConstants.fromColor(color).kRoboto14,
                  ),
                ),
              )
            : SizedBox(
                width: (width != null) ? width! - 48 : null,
                child: Center(
                  child: Text(
                    text.tr,
                    style: FondueSwapConstants.fromColor(color).kRoboto14,
                  ),
                ),
              ),
      ),
    );
  }
}
