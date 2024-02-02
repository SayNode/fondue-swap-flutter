import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';

import '../../../services/theme_service.dart';
import '../../../theme/custom_theme.dart';
import '../../../utils/globals.dart';
import '../../../utils/password_utils.dart';
import '../../home/home_page_loader.dart';

class LoginController extends GetxController {
  TextEditingController passwordController = TextEditingController();
  RxBool validPassword = true.obs;
  RxBool isBiometricsOn = false.obs;
  final LocalAuthentication auth = LocalAuthentication();
  final FondueSwapTheme fondueTheme = Get.put(ThemeService()).fondueSwapTheme;

  @override
  Future<void> onInit() async {
    super.onInit();
    isBiometricsOn.value = await _isBiometricsOn();
  }

  Future<bool> _isBiometricsOn() async {
    const FlutterSecureStorage storage = FlutterSecureStorage();
    final String? biometrics = await storage.read(key: biometricsKey);
    if (biometrics == null) {
      return false;
    }
    return biometrics == 'true';
  }

  Future<void> biometricsLogin() async {
    debugPrint('biometric login enabled');

    final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
    final List<BiometricType> availableBiometrics =
        await auth.getAvailableBiometrics();

    if (canAuthenticateWithBiometrics && availableBiometrics.isNotEmpty) {
      try {
        final bool isAuthenticated = await auth.authenticate(
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
        "This device isn't compatible with biometric authentication.",
        colorText: fondueTheme.cherryRed,
      );
    }
  }

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
