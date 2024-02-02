import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../services/theme_service.dart';
import '../../theme/constants.dart';
import '../../theme/custom_theme.dart';
import '../../widgets/fondue_scaffold.dart';
import 'onboarding_page_4.dart';
import 'widgets/grouped_button_onboarding_widget.dart';

class OnboardingPage3 extends StatelessWidget {
  const OnboardingPage3({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final FondueSwapTheme fondueSwapTheme =
        Get.put(ThemeService()).fondueSwapTheme;
    return FondueScaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(height: MediaQuery.of(context).size.height * 0.07),
            Image.asset(
              'assets/images/phone_screen_3.png',
              scale: 4,
            ),
            SizedBox(height: screenSize.height * 0.05),
            Text(
              'Earn Rewards with Pooling'.tr,
              style:
                  FondueSwapConstants.fromColor(fondueSwapTheme.mistyLavender)
                      .kRoboto22,
            ),
            SizedBox(height: screenSize.height * 0.03),
            SizedBox(
              width: screenSize.width * 0.78,
              child: Text(
                'Earn rewards and unlock passive income  liquidity pools'.tr,
                style:
                    FondueSwapConstants.fromColor(fondueSwapTheme.mistyLavender)
                        .kRoboto16,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: screenSize.height * 0.16),
            GroupedButtonOnboarding(
              slide: 'assets/images/slide_2.png',
              onTapButton: () {
                Get.to<Widget>(() => const OnboardingPage4());
              },
              onTapTextButton: () {},
            ),
          ],
        ),
      ),
    );
  }
}
