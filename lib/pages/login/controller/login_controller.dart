import 'package:flutter/cupertino.dart';
import 'package:fondue_swap/pages/home/home_page_loader.dart';
import 'package:get/get.dart';

import '../../../utils/password_utils.dart';

class LoginController extends GetxController {
  TextEditingController passwordController = TextEditingController();

  RxBool validPassword = true.obs;

  submit() async {
    bool isPasswordValid = await checkPassword(passwordController.text);

    if (isPasswordValid) {
      debugPrint("Welcome");

      validPassword.value = true;
      passwordController.text = '';
      debugPrint("correct password");
      Get.offAll(() => const HomePageLoader());
    } else {
      validPassword.value = false;

      debugPrint("Wrong password");
    }
  }
}
