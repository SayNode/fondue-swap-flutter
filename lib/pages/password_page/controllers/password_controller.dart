import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/password_utils.dart';

class PasswordController extends GetxController {
  TextEditingController passwordController = TextEditingController();
  RxBool validPassword = true.obs;
  late Function passedFunction;

  Future<void> submit() async {
    debugPrint('submit');
    if (await checkPassword(passwordController.text)) {
      // ignore: avoid_dynamic_calls
      passedFunction(passwordController.text);
    } else {
      validPassword.value = false;
    }
  }
}
