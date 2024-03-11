import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../services/theme_service.dart';
import '../../theme/constants.dart';
import '../../theme/custom_theme.dart';
import '../../widgets/fondue_scaffold.dart';
import 'onboarding_page_2.dart';

class OnboardingPage1 extends StatelessWidget {
  const OnboardingPage1({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final FondueSwapTheme fondueSwapTheme =
        Get.put(ThemeService()).fondueSwapTheme;
    return FondueScaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: <Widget>[
              SizedBox(height: screenSize.height * 0.15),
              Image.asset('assets/images/fondue.png', scale: 4),
              SizedBox(height: screenSize.height * 0.07),
              Text(
                'Welcome to FondueSwap'.tr,
                style:
                    FondueSwapConstants.fromColor(fondueSwapTheme.mistyLavender)
                        .kRoboto22,
              ),
              SizedBox(height: screenSize.height * 0.03),
              SizedBox(
                width: screenSize.width * 0.6,
                child: Text(
                  'Experience seamless cryptocurrency swapping and pooling'.tr,
                  textAlign: TextAlign.center,
                  style: FondueSwapConstants.fromColor(
                    fondueSwapTheme.mistyLavender,
                  ).kRoboto16,
                ),
              ),
              SizedBox(height: screenSize.height * 0.15),
              GestureDetector(
                onTap: () {
                  Get.to<Widget>(() => const OnboardingPage2());
                },
                child: SvgPicture.asset('assets/icons/orange_button.svg'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
