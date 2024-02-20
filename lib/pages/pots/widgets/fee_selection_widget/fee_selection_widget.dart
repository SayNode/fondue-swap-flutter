import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../services/theme_service.dart';
import '../../../../theme/constants.dart';
import '../../../../theme/custom_theme.dart';
import 'controller/fee_selection_controller.dart';

class FeeSelectionWidget extends GetView<FeeSelectionController> {
  const FeeSelectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(FeeSelectionController());
    final FondueSwapTheme theme = Get.put(ThemeService()).fondueSwapTheme;
    return Obx(
      () {
        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
          ),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: theme.graphite,
            ),
          ),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    '${controller.fee.value}% fee tier',
                    textAlign: TextAlign.center,
                    style: FondueSwapConstants.fromColor(theme.mistyLavender)
                        .kRoboto16,
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () =>
                        controller.expanded.value = !controller.expanded.value,
                    icon: Icon(
                      (controller.expanded.value)
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: theme.goldenSunset,
                    ),
                  ),
                ],
              ),
              if (controller.expanded.value)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: controller.buildFeeBoxes(),
                  ),
                )
              else
                const SizedBox.shrink(),
            ],
          ),
        );
      },
    );
  }
}
