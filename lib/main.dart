import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'pages/splash_page/splash_page.dart';
import 'services/theme_service.dart';
import 'services/translation_service.dart';

Future<void> main() async {
  await GetStorage.init('theme');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      transitionDuration: Duration.zero,
      translations: AppTranslations(),
      locale: const Locale('en', 'US'),
      fallbackLocale: const Locale('en', 'US'),
      title: 'Fondue Swap',
      theme: Get.put(ThemeService()).theme,
      home: const SplashPage(),
    );
  }
}
