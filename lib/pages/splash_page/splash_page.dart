import 'package:flutter/material.dart';
import 'package:fondue_swap/pages/onboarding_pages/onboard_page_1.dart';
import 'package:get/get.dart';

import 'controller/splash_controller.dart';

class SplashPage extends GetView<SplashPageController> {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const OnboardingFirstPage();
  }
}
