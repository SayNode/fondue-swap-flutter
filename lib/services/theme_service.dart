import 'package:flutter/material.dart';
import 'package:fondue_swap/theme/custom_theme.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeService extends GetxService {
  final _getStorage = GetStorage('theme');

  ThemeData get theme => _getTheme();

  FondueSwapTheme get fondueSwapTheme => Get.theme.extension<FondueSwapTheme>()!;

  ThemeData _getTheme() {
    String theme = getSavedTheme();
    debugPrint('Loading theme: $theme');

    switch (theme) {
      case 'dark':
        return ThemeData(extensions: const [FondueSwapTheme.dark]);
      default:
        return ThemeData(extensions: const [FondueSwapTheme.dark]);
    }
  }

  String getSavedTheme() {
    var value = _getStorage.read('themeMode');
    return value ?? 'dark';
  }
}
