import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../services/theme_service.dart';
import '../../../../theme/constants.dart';

class SeedWordCard extends StatelessWidget {
  const SeedWordCard({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Get.put(ThemeService()).fondueSwapTheme;
    return Container(
        //add input decoration with rounded corners
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: theme.graphite,
        ),
        padding: const EdgeInsets.all(12),
        child: Text(
          text,
          style: FondueSwapConstants.fromColor(theme.mistyLavender).kRoboto14,
        ));
  }
}
