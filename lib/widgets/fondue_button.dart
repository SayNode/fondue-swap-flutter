import 'package:flutter/material.dart';
import 'package:fondue_swap/theme/constants.dart';
import 'package:get/get.dart';

import '../services/theme_service.dart';

class FondueButton extends StatelessWidget {
  final String text;
  final dynamic Function()? onTap;
  final bool disabled;
  final bool expanded;
  final double? width;
  const FondueButton({
    super.key,
    required this.text,
    this.onTap,
    this.disabled = false,
    this.expanded = false,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Get.put(ThemeService()).fondueSwapTheme;
    final color = (disabled) ? theme.stormyNight : theme.goldenSunset;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(256),
        ),
        backgroundColor: Colors.transparent,
        side: BorderSide(
          color: color,
          width: 1,
        ),
      ),
      onPressed: (disabled) ? null : onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 24,
        ),
        child: (expanded)
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
