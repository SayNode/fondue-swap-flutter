import 'package:flutter/material.dart';
import 'package:fondue_swap/pages/splash_page/splash_page.dart';
import 'package:fondue_swap/services/theme_service.dart';
import 'package:fondue_swap/services/translation_service.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

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
      translations: AppTranslations(),
      locale: const Locale('en', 'US'),
      fallbackLocale: const Locale('en', 'US'),
      title: 'Legacy Wallet',
      debugShowCheckedModeBanner: false,
      theme: Get.put(ThemeService()).theme,
      home: const SplashPage(),
    );
  }
}
