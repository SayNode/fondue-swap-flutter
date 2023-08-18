import 'package:flutter/material.dart';
import 'package:fondue_swap/pages/signup_pages.dart/create_password.dart';
import 'package:get/get.dart';

import 'controller/splash_controller.dart';

class SplashPage extends GetView<SplashPageController> {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CreatePasswordPage();
  }
}
