import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../signup_pages.dart/create_password.dart';

class OnboardingController extends GetxController {
  final PageController pageController = PageController();
  RxInt currentPage = 0.obs;

  List<Map<String, String>> pageList = <Map<String, String>>[
    <String, String>{
      'image': 'assets/images/phone_screen_2.png',
      'title': 'Swap Anytime, Anywhere'.tr,
      'subtitle':
          'Effortlessly swap cryptos for diversification and market opportunities with FondueSwap'
              .tr,
    },
    <String, String>{
      'image': 'assets/images/phone_screen_3.png',
      'title': 'Earn Rewards with Pooling'.tr,
      'subtitle': 'Earn rewards and unlock passive income liquidity pools'.tr,
    },
    <String, String>{
      'image': 'assets/images/phone_screen_4.png',
      'title': 'Safeguard Your Crypto Assets'.tr,
      'subtitle': 'Take control of your finances'.tr,
    }
  ];

  Future<void> onPressed() async {
    if (currentPage.value < pageList.length - 1) {
      currentPage.value = currentPage.value + 1;
      animateTo(currentPage.value);
    } else {
      await Get.to<void>(() => const CreatePasswordPage());
    }
  }

  void animateTo(int value) {
    pageController.animateToPage(
      value,
      duration: const Duration(milliseconds: 300),
      curve: Curves.decelerate,
    );
  }
}
