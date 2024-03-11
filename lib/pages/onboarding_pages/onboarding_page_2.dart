import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../services/theme_service.dart';
import '../../theme/constants.dart';
import '../../theme/custom_theme.dart';
import '../../widgets/fondue_scaffold.dart';
import '../signup_pages.dart/create_password.dart';
import 'controller/onboarding_controller.dart';
import 'widgets/slide_marker.dart';

class OnboardingPage2 extends GetView<OnboardingController> {
  const OnboardingPage2({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    final FondueSwapTheme fondueSwapTheme =
        Get.put(ThemeService()).fondueSwapTheme;
    Get.put(OnboardingController());
    Widget page(
      String image,
      String title,
      String subtitle,
    ) =>
        Column(
          children: <Widget>[
            SizedBox(height: MediaQuery.of(context).size.height * 0.07),
            Image.asset(
              image,
              scale: 4,
            ),
            SizedBox(height: screenSize.height * 0.05),
            Text(
              title,
              style:
                  FondueSwapConstants.fromColor(fondueSwapTheme.mistyLavender)
                      .kRoboto22,
            ),
            SizedBox(height: screenSize.height * 0.03),
            SizedBox(
              width: screenSize.width * 0.78,
              child: Text(
                subtitle.tr,
                style: FondueSwapConstants.fromColor(
                  fondueSwapTheme.mistyLavender,
                ).kRoboto16,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: screenSize.height * 0.01),
          ],
        );
    return FondueScaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: PageView(
              controller: controller.pageController,
              onPageChanged: (int index) =>
                  controller.currentPage.value = index,
              children: controller.pageList
                  .map(
                    (Map<String, String> p) => page(
                      p['image'] ?? '',
                      p['title'] ?? '',
                      p['subtitle'] ?? '',
                    ),
                  )
                  .toList(),
            ),
          ),
          Column(
            children: <Widget>[
              Obx(
                () => SlideMarker(
                  height: screenSize.height * 0.0025,
                  stateCount: controller.pageList.length,
                  actualState: controller.currentPage.value,
                  controller: controller,
                ),
              ),
              GestureDetector(
                onTap: controller.onPressed,
                child: SvgPicture.asset('assets/icons/orange_button.svg'),
              ),
              TextButton(
                onPressed: () {
                  Get.to<void>(() => const CreatePasswordPage());
                },
                child: Text(
                  'Skip introduction'.tr,
                  style: FondueSwapConstants.fromColor(
                    fondueSwapTheme.mistyLavender,
                  ).kRoboto14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
