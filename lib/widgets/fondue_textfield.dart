import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../services/theme_service.dart';
import '../../../theme/constants.dart';

class FondueTextField extends StatelessWidget {
  const FondueTextField({super.key, this.controller, this.onChanged, this.onSubmitted, this.hintText});
  final TextEditingController? controller;
  final String? hintText;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;

  @override
  Widget build(BuildContext context) {
    final theme = Get.put(ThemeService()).fondueSwapTheme;
    return TextField(
      onSubmitted: onSubmitted,
      textInputAction: TextInputAction.done,
      onChanged: onChanged,
      controller: controller,
      style: FondueSwapConstants.fromColor(theme.mistyLavender).kRoboto16,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: theme.goldenSunset),
        ),
        filled: true,
        fillColor: theme.graphite,
        hintText: hintText,
        hintStyle: FondueSwapConstants.fromColor(theme.mistyLavender).kRoboto16,
        labelStyle: FondueSwapConstants.fromColor(theme.mistyLavender).kRoboto16,
      ),
    );
  }
}
