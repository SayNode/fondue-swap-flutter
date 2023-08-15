import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../services/theme_service.dart';

class FondueTextfield extends StatelessWidget {
  const FondueTextfield({super.key, this.labelText});

  final String? labelText;

  @override
  Widget build(BuildContext context) {
    final theme = Get.put(ThemeService()).fondueSwapTheme;
    return TextField(
      decoration: InputDecoration(
        filled: true,
        fillColor: theme.graphite,
        labelText: labelText,
        labelStyle: const TextStyle(
          color: Colors.red,
        ),
      ),
    );
  }
}
