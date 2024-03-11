import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../theme/custom_theme.dart';

class ThemeService extends GetxService {
  final GetStorage _getStorage = GetStorage('theme');

  ThemeData get theme => _getTheme();

  FondueSwapTheme get fondueSwapTheme =>
      Get.theme.extension<FondueSwapTheme>()!;

  ThemeData _getTheme() {
    final String theme = getSavedTheme();
    debugPrint('Loading theme: $theme');

    switch (theme) {
      case 'dark':
        return ThemeData(
          extensions: const <ThemeExtension<FondueSwapTheme>>[
            FondueSwapTheme.dark,
          ],
        );
      default:
        return ThemeData(
          extensions: const <ThemeExtension<FondueSwapTheme>>[
            FondueSwapTheme.dark,
          ],
        );
    }
  }

  String getSavedTheme() {
    final String? value = _getStorage.read('themeMode');
    return value ?? 'dark';
  }
}
