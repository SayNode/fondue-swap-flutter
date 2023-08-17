import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../utils/password.dart';

class SignUpController extends GetxController {
  RxBool isButtonEnabled = false.obs;
  final passwordStrength = Password();
  RxBool obscureText = true.obs;
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  RxBool matches = false.obs;

  void visiblePassword() {
    obscureText.value = !obscureText.value;
  }

  updateMatch() {
    if (confirmPasswordController.text.compareTo(passwordController.text) == 0) {
      matches.value = true;
    } else {
      matches.value = false;
    }
  }
}
