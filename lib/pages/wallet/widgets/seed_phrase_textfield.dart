import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../services/theme_service.dart';
import '../../../theme/constants.dart';

class SeedPhraseTextField extends StatelessWidget {
  const SeedPhraseTextField({super.key, this.controller, this.onChanged, this.onSubmitted});
  final TextEditingController? controller;
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
      minLines: 5,
      maxLines: 5,
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
        hintText: 'Enter seed phrase'.tr,
        hintStyle: FondueSwapConstants.fromColor(theme.mistyLavender).kRoboto16,
        labelStyle: FondueSwapConstants.fromColor(theme.mistyLavender).kRoboto16,
      ),
    );
  }
}
