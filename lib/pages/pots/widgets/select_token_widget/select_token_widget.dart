import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../services/theme_service.dart';
import '../../../../theme/constants.dart';
import '../../../../theme/custom_theme.dart';
import '../../../../utils/util.dart';
import 'controller/select_token_controller.dart';

class SelectTokenWidget extends GetView<SelectTokenController> {
  const SelectTokenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final FondueSwapTheme theme = Get.put(ThemeService()).fondueSwapTheme;
    Get.put(SelectTokenController());
    return Row(
      children: <Widget>[
        Expanded(
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(theme.graphite),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            onPressed: () {
              controller.selectTokenX();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Obx(
                  () {
                    return Text(
                      controller.newPositionService.tokenX.value != null
                          ? controller.newPositionService.tokenX.value!.name
                          : 'Select a token',
                      style: FondueSwapConstants.fromColor(theme.mistyLavender)
                          .kRoboto16,
                    );
                  },
                ),
                Icon(
                  Icons.keyboard_arrow_down,
                  color: theme.goldenSunset,
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          width: getRelativeWidth(10),
        ),
        Expanded(
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(theme.graphite),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            onPressed: () {
              controller.selectTokenY();
            },
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Obx(
                    () {
                      return Text(
                        controller.newPositionService.tokenY.value != null
                            ? controller.newPositionService.tokenY.value!.name
                            : 'Select a token',
                        style:
                            FondueSwapConstants.fromColor(theme.mistyLavender)
                                .kRoboto16,
                      );
                    },
                  ),
                  Icon(
                    Icons.keyboard_arrow_down,
                    color: theme.goldenSunset,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
