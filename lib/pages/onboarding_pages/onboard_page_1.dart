import 'package:flutter/material.dart';
import 'package:fondue_swap/pages/widgets/fondue_scaffold.dart';
import 'package:fondue_swap/theme/constants.dart';
import 'package:get/get.dart';

import '../../services/theme_service.dart';
import '../../theme/custom_theme.dart';

class OnboardingFirstPage extends StatelessWidget {
  const OnboardingFirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    FondueSwapTheme fondueSwapTheme = Get.put(ThemeService()).fondueSwapTheme;
    return FondueScaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: screenSize.height * 0.15),
            Image.asset('assets/images/fondue.png', scale: 4),
            Text(
              'Welcome to FondueSwap',
              style: FondueSwapConstants.fromColor(fondueSwapTheme.mistyLavender).kRoboto22,
            ),
          ],
        ),
      ),
    );
  }
}
