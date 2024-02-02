import 'package:flutter/cupertino.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fondue_swap/services/theme_service.dart';
import 'package:fondue_swap/utils/globals.dart';

import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';

import '../../../utils/password_utils.dart';
import '../../home/home_page_loader.dart';

class LoginController extends GetxController {
  TextEditingController passwordController = TextEditingController();
  RxBool validPassword = true.obs;
  RxBool isBiometricsOn = false.obs;
  final LocalAuthentication auth = LocalAuthentication();
  final fondueTheme = Get.put(ThemeService()).fondueSwapTheme;

  @override
  onInit() async {
    super.onInit();
    isBiometricsOn.value = await _isBiometricsOn();
  }

  Future<bool> _isBiometricsOn() async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    String? biometrics = await storage.read(key: biometricsKey);
    if (biometrics == null) {
      return false;
    }
    return biometrics == 'true';
  }

  Future<void> biometricsLogin() async {
    debugPrint("biometric login enabled");

    final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
    final List<BiometricType> availableBiometrics =
        await auth.getAvailableBiometrics();

    if (canAuthenticateWithBiometrics && availableBiometrics.isNotEmpty) {
      try {
        bool isAuthenticated = await auth.authenticate(
          localizedReason: 'Please authenticate.',
          options: const AuthenticationOptions(
            stickyAuth: true,
            biometricOnly: true,
          ),
        );
        if (isAuthenticated) {
          // TODO: Login
        }
      } catch (e) {
        debugPrint(e.toString());
        Get.snackbar(
          'Something went wrong',
          'There was a problem with biometric authentication. Please try again.',
          colorText: fondueTheme.cherryRed,
        );
      }
    } else {
      Get.snackbar(
        'Something went wrong',
        'This device isn\'t compatible with biometric authentication.',
        colorText: fondueTheme.cherryRed,
      );
    }
  }


  void submit() async {
    bool isPasswordValid = await checkPassword();


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
