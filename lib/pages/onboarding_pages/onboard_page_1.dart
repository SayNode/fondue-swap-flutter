import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fondue_swap/pages/onboarding_pages/onboarding_page_2.dart';
import 'package:fondue_swap/theme/constants.dart';
import 'package:fondue_swap/widgets/fondue_scaffold.dart';
import 'package:get/get.dart';

import '../../services/theme_service.dart';
import '../../theme/custom_theme.dart';

class OnboardingPage1 extends StatelessWidget {
  const OnboardingPage1({super.key});

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
            SizedBox(height: screenSize.height * 0.07),
            Text('Welcome to FondueSwap'.tr,
                style:
                    FondueSwapConstants.fromColor(fondueSwapTheme.mistyLavender)
                        .kRoboto22),
            SizedBox(height: screenSize.height * 0.03),
            SizedBox(
                width: screenSize.width * 0.6,
                child: Text(
                    'Experience seamless cryptocurrency swapping and pooling'
                        .tr,
                    textAlign: TextAlign.center,
                    style: FondueSwapConstants.fromColor(
                            fondueSwapTheme.mistyLavender)
                        .kRoboto16)),
            SizedBox(height: screenSize.height * 0.15),
            GestureDetector(
              onTap: () {
                Get.to(() => const OnboardingPage2());
              },
              child: SvgPicture.asset('assets/icons/orange_button.svg'),
            ),
          ],
        ),
      ),
    );
  }
}
