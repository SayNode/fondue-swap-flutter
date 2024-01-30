import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../utils/password_utils.dart';
import '../../home/home_page_loader.dart';

class LoginController extends GetxController {
  TextEditingController passwordController = TextEditingController();

  RxBool validPassword = true.obs;

  Future<void> submit() async {
    final bool isPasswordValid = await checkPassword(passwordController.text);

    if (isPasswordValid) {
      debugPrint('Welcome');

      validPassword.value = true;
      passwordController.text = '';
      debugPrint('correct password');
      await Get.offAll<Widget>(() => const HomePageLoader());
    } else {
      validPassword.value = false;

      debugPrint('Wrong password');
    }
  }
}
