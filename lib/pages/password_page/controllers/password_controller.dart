import 'package:flutter/material.dart';
import 'package:fondue_swap/utils/password_utils.dart';
import 'package:get/get.dart';

class PasswordController extends GetxController {
  TextEditingController passwordController = TextEditingController();
  RxBool validPassword = true.obs;
  late Function passedFunction;

  void submit() async {
    debugPrint('submit');
    if (await checkPassword(passwordController.text)) {
      passedFunction(passwordController.text);
    } else {
      validPassword.value = false;
    }
  }
}
