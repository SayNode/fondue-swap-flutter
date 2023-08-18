import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../services/theme_service.dart';
import '../../../theme/constants.dart';

class SeedPhraseTextField extends StatelessWidget {
  const SeedPhraseTextField({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Get.put(ThemeService()).fondueSwapTheme;
    return TextField(
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
