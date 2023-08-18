import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/theme_service.dart';

class FondueScaffold extends StatelessWidget {
  const FondueScaffold({super.key, required this.body, this.appBar});
  final PreferredSizeWidget? appBar;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    final theme = Get.put(ThemeService()).fondueSwapTheme;
    return Scaffold(
      backgroundColor: theme.midnightBlack,
      resizeToAvoidBottomInset: false,
      appBar: appBar,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: body,
      ),
    );
  }
}
