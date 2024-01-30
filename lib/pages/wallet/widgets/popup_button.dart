import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../services/theme_service.dart';

class PopupButton extends StatelessWidget {
  const PopupButton({required this.text, super.key, this.onPressed});
  final String text;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final Color color = Get.put(ThemeService()).fondueSwapTheme.mistyLavender;
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        backgroundColor: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
          side: BorderSide(color: color),
        ),
      ),
      child: Text(
        text.tr,
        style: TextStyle(
          color: color,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
