import 'package:flutter/material.dart';
import 'package:fondue_swap/pages/home/home_page_loader.dart';
import 'package:get/get.dart';

import 'controller/splash_controller.dart';

class SplashPage extends GetView<SplashPageController> {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashPageController());
    // return const CreatePasswordPage();
    return const HomePageLoader();
  }
}
