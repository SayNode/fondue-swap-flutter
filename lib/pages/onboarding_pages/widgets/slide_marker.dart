import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../services/theme_service.dart';
import '../../../theme/custom_theme.dart';
import '../controller/onboarding_controller.dart';

class SlideMarker extends StatelessWidget {
  const SlideMarker({
    required this.stateCount,
    required this.actualState,
    required this.height,
    required this.controller,
    super.key,
  });

  final int stateCount;
  final int actualState;
  final double height;
  final OnboardingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: slider(),
      ),
    );
  }

  List<Widget> slider() {
    final int state = actualState % stateCount;
    final FondueSwapTheme fondueSwapTheme =
        Get.put(ThemeService()).fondueSwapTheme;

    final List<Widget> list = <Widget>[];
    for (int i = 0; i < stateCount; i++) {
      if (i == state) {
        list.add(
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: SizedBox(
              width: height * 18,
              height: height,
              child: Container(
                decoration: BoxDecoration(
                  color: fondueSwapTheme.goldenSunset,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
              ),
            ),
          ),
        );
      } else {
        list.add(
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: SizedBox(
              width: height * 18,
              height: height,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20),
                  ),
                  color: fondueSwapTheme.mistyLavender,
                ),
              ),
            ),
          ),
        );
      }
    }
    return list;
  }
}
