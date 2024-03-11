import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../services/new_position_service.dart';
import '../../../../services/theme_service.dart';
import '../../../../theme/constants.dart';
import '../../../../theme/custom_theme.dart';

class FeeBox extends StatelessWidget {
  const FeeBox({required this.fee, required this.description, super.key});
  final double fee;
  final String description;

  @override
  Widget build(BuildContext context) {
    final FondueSwapTheme theme = Get.put(ThemeService()).fondueSwapTheme;
    final NewPositionService newPositionService =
        Get.find<NewPositionService>();
    return GestureDetector(
      onTap: () {
        newPositionService.fee.value = fee;
      },
      child: Obx(
        () {
          return Container(
            padding: const EdgeInsets.all(
              8,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: (newPositionService.fee.value == fee)
                    ? theme.goldenSunset
                    : theme.graphite,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '$fee%',
                  textAlign: TextAlign.center,
                  style: FondueSwapConstants.fromColor(theme.mistyLavender)
                      .kRoboto16,
                ),
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: FondueSwapConstants.fromColor(theme.mistyLavender)
                      .kRoboto10,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
