import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/theme_service.dart';
import '../theme/custom_theme.dart';

class FondueScaffold extends StatelessWidget {
  const FondueScaffold({
    required this.body,
    super.key,
    this.appBar,
    this.bottomNavigationBar,
  });
  final PreferredSizeWidget? appBar;
  final Widget body;
  final Widget? bottomNavigationBar;

  @override
  Widget build(BuildContext context) {
    final FondueSwapTheme theme = Get.put(ThemeService()).fondueSwapTheme;
    return Scaffold(
      backgroundColor: theme.midnightBlack,
      resizeToAvoidBottomInset: false,
      appBar: appBar,
      bottomNavigationBar: bottomNavigationBar,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: body,
      ),
    );
  }
}
