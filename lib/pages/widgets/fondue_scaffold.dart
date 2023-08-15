import 'package:flutter/material.dart';
import 'package:fondue_swap/theme/colors.dart';
import 'package:get/get.dart';

import '../../services/theme_service.dart';

class FondueScaffold extends StatelessWidget {
  const FondueScaffold({super.key, required this.body});

  final Widget body;

  @override
  Widget build(BuildContext context) {
    final themeService = Get.put(ThemeService());
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: screenHeight * 1,
        decoration: const BoxDecoration(color: FondueSwapColor.midnightBlack),
        child: body,
      ),
    );
  }
}
