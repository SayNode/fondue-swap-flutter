import 'package:flutter/material.dart';
import '../../../../theme/constants.dart';
import 'package:get/get.dart';

import '../../../../services/theme_service.dart';
import '../../../../theme/custom_theme.dart';

class SecurityText extends StatelessWidget {
  const SecurityText({
    required this.title,
    required this.description,
    super.key,
  });
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    final FondueSwapTheme theme = Get.put(ThemeService()).fondueSwapTheme;
    return Align(
      alignment: Alignment.centerLeft,
      child: RichText(
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(
              text: title,
              style:
                  FondueSwapConstants.fromColor(theme.goldenSunset).kRoboto14,
            ),
            TextSpan(
              text: description,
              style:
                  FondueSwapConstants.fromColor(theme.mistyLavender).kRoboto14,
            ),
          ],
        ),
      ),
    );
  }
}
