import 'package:crypt/crypt.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import '../../../models/password/password_strength.dart';
import '../../../services/theme_service.dart';
import '../../../utils/globals.dart';
import '../../home/home_page_loader.dart';

class SignUpController extends GetxController {
  final FocusNode textFieldNode = FocusNode();
  RxBool isButtonLocked = true.obs;
  final PasswordStrength passwordStrength = PasswordStrength();
  RxBool obscureText = true.obs;
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  RxBool matches = false.obs;
  RxBool strong = false.obs;
  RxBool isBiometricsEnabled = false.obs;

  void onPasswordChanged1(String value) {
    if (passwordStrength.update(passwordController.text) >= 5) {
      strong.value = true;
    }
    _updateButtonState();
  }

  void onPasswordChanged2(String value) {
    _updateButtonState();
  }

  bool togglePasswordVisibility() {
    // ignore: join_return_with_assignment
    obscureText.value = !obscureText.value;
    return obscureText.value;
  }

  bool _updateButtonState() {
    if (confirmPasswordController.text.compareTo(passwordController.text) ==
            0 &&
        strong.value) {
      isButtonLocked.value = false;
    } else {
      isButtonLocked.value = true;
    }
    return isButtonLocked.value;
  }

  // Callback to switch onChange

  // ignore: avoid_positional_boolean_parameters, use_setters_to_change_properties
  void onBiometricsSwitchChange(bool value) {
    isBiometricsEnabled.value = value;
    // TODO Store biometrics preference?
  }

  // Callback for when button tapped, when it's locked
  void onButtonLockedTap() {
    if (confirmPasswordController.text.compareTo(passwordController.text) !=
        0) {
      Get.snackbar(
        'Oops',
        "Passwords don't match",
        colorText: Get.put(ThemeService()).fondueSwapTheme.cherryRed,
      );
    } else if (!strong.value) {
      Get.snackbar(
        'Oops',
        "Password isn't strong enough",
        colorText: Get.put(ThemeService()).fondueSwapTheme.cherryRed,
      );
    } else {
      Get.snackbar(
        'Oops',
        'An error occurred',
        colorText: Get.put(ThemeService()).fondueSwapTheme.cherryRed,
      );
    }
  }

  // Callback for when button tapped, when it's unlocked
  Future<void> onButtonTap() async {
    const FlutterSecureStorage storage = FlutterSecureStorage();
    final String hashedPassword =
        Crypt.sha512(passwordController.text).toString();
    await storage.write(key: encryptedMessage, value: hashedPassword);
    await Get.offAll<Widget>(
      const HomePageLoader(),
    );
  }
}
