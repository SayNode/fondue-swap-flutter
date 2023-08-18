import 'package:crypt/crypt.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fondue_swap/services/theme_service.dart';
import 'package:fondue_swap/utils/globals.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';

import '../../../models/password/password_strength.dart';

class SignUpController extends GetxController {
  final textFieldNode = FocusNode();
  RxBool isButtonLocked = true.obs;
  final passwordStrength = PasswordStrength();
  RxBool obscureText = true.obs;
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  RxBool matches = false.obs;
  RxBool strong = false.obs;
  RxBool isBiometricsEnabled = false.obs;
  final LocalAuthentication auth = LocalAuthentication();

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

  Future<bool> checkBiometricsCompatibility() async {
    final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
    final List<BiometricType> availableBiometrics =
        await auth.getAvailableBiometrics();

    return canAuthenticateWithBiometrics && availableBiometrics.isNotEmpty;
  }

  // Callback to switch onChange
  void onBiometricsSwitchChange(bool value) async {
    isBiometricsEnabled.value = value;
    FlutterSecureStorage storage = const FlutterSecureStorage();
    await storage.write(
        key: biometricsKey, value: isBiometricsEnabled.value.toString());
    if (isBiometricsEnabled.value) {
      checkBiometricsCompatibility().then((res) async {
        if (!res) {
          isBiometricsEnabled.value = false;
          await storage.write(
              key: biometricsKey, value: isBiometricsEnabled.value.toString());
          Get.snackbar(
            'Biometrics not supported',
            'This device isn\'t compatible with biometric authentication.',
            colorText: Get.put(ThemeService()).fondueSwapTheme.cherryRed,
          );
        }
      });
    }
    debugPrint(await storage.read(key: biometricsKey));
  }

  // Callback for when button tapped, when it's locked
  void onButtonLockedTap() {
    if (confirmPasswordController.text.compareTo(passwordController.text) !=
        0) {
      Get.snackbar('Oops', 'Passwords don\'t match',
          colorText: Get.put(ThemeService()).fondueSwapTheme.cherryRed);
    } else if (!strong.value) {
      Get.snackbar('Oops', 'Password isn\'t strong enough',
          colorText: Get.put(ThemeService()).fondueSwapTheme.cherryRed);
    } else {
      Get.snackbar('Oops', 'An error occurred',
          colorText: Get.put(ThemeService()).fondueSwapTheme.cherryRed);
    }
  }

  // Callback for when button tapped, when it's unlocked
  void onButtonTap() async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    String hashedPassword = Crypt.sha512(passwordController.text).toString();
    await storage.write(key: encryptedMessage, value: hashedPassword);
    debugPrint('go to next page');
  }
}
