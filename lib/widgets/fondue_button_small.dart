import 'package:flutter/material.dart';
import 'package:fondue_swap/services/theme_service.dart';
import 'package:fondue_swap/theme/colors.dart';
import 'package:fondue_swap/theme/constants.dart';
import 'package:get/get.dart';

class SmallFondueButton extends StatelessWidget {
  final bool locked;
  final String text;
  final dynamic Function()? onTap;

  /// Function to call when clicking the button when it's locked
  final dynamic Function()? onTapLocked;

  const SmallFondueButton({
    super.key,
    this.locked = false,
    required this.text,
    this.onTapLocked,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Get.put(ThemeService()).fondueSwapTheme;
    var screenSize = MediaQuery.of(context).size;
    return ElevatedButton(
      onPressed: () {
        if (locked) {
          onTapLocked?.call();
        } else {
          onTap?.call();
        }
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(256)),
        backgroundColor: Colors.transparent,
        side: BorderSide(
          color: locked ? FondueSwapColor.graphite : FondueSwapColor.goldenSunset,
          width: 2,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(screenSize.width * 0.03),
        child: Text(text, style: FondueSwapConstants.fromColor(locked ? theme.graphite : theme.goldenSunset).kRoboto14),
      ),
    );
  }
}
