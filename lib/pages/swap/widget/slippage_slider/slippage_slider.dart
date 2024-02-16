import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../services/theme_service.dart';
import '../../../../theme/constants.dart';
import '../../../../theme/custom_theme.dart';
import 'slippage_slider_controller.dart';

class SlippageSlider extends GetView<SlippageSliderController> {
  const SlippageSlider({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SlippageSliderController());
    final FondueSwapTheme theme = Get.put(ThemeService()).fondueSwapTheme;

    return Container(
      padding: const EdgeInsets.all(
        12,
      ),
      width: double.infinity,
      decoration: BoxDecoration(
        color: theme.graphite,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Slippage',
              style:
                  FondueSwapConstants.fromColor(theme.mistyLavender).kRoboto14,
            ),
          ),
          const SizedBox(
            height: 9,
          ),
          Container(
            height: 41,
            width: 48,
            decoration: BoxDecoration(
              color: theme.mistyLavender,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Center(
              child: Obx(
                () {
                  return Text(
                    '${controller.swapService.slippage.value}%',
                    style:
                        FondueSwapConstants.fromColor(theme.graphite).kRoboto14,
                  );
                },
              ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 14),
                child: Text(
                  '0%',
                  style: FondueSwapConstants.fromColor(theme.mistyLavender)
                      .kRoboto10,
                ),
              ),
              const SizedBox(
                width: 6,
              ),
              //round container wraped in gesturedetector
              Obx(
                () {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    child: Container(
                      height: 16,
                      width: 9 + controller.offset.value,
                      decoration: BoxDecoration(
                        color: theme.goldenSunset,
                        borderRadius: const BorderRadius.horizontal(
                          left: Radius.circular(16),
                        ),
                      ),
                    ),
                  );
                },
              ),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onHorizontalDragEnd: controller.swapService.fetchingPrice.value
                    ? null
                    : controller.onDragEnd,
                onHorizontalDragUpdate:
                    controller.swapService.fetchingPrice.value
                        ? null
                        : controller.onDragUpdate,
                child: Column(
                  children: <Widget>[
                    //container with 48, height 41 width and rounded corners and color mistyLavender

                    const SizedBox(
                      height: 7,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: Container(
                        height: 44,
                        width: 2,
                        decoration: BoxDecoration(
                          color: theme.mistyLavender,
                          borderRadius: const BorderRadius.horizontal(
                            right: Radius.circular(2),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                //add container as child with height 16 and rounded corners
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  child: Container(
                    height: 16,
                    decoration: BoxDecoration(
                      color: theme.mistyLavender,
                      borderRadius: const BorderRadius.horizontal(
                        right: Radius.circular(16),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 6,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 14),
                child: Text(
                  '25%',
                  style: FondueSwapConstants.fromColor(theme.mistyLavender)
                      .kRoboto10,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
