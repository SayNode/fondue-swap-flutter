import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../../../services/theme_service.dart';
import '../../../../theme/constants.dart';
import '../../../../theme/custom_theme.dart';
import '../../../../utils/util.dart';
import 'controller/price_range_selector_controller.dart';
import 'price_range_textfield_box.dart';

class PriceRangeSelectorWidget extends GetView<PriceRangeSelectorController> {
  const PriceRangeSelectorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(PriceRangeSelectorController());
    final FondueSwapTheme theme = Get.put(ThemeService()).fondueSwapTheme;
    return Obx(
      () {
        return Column(
          children: <Widget>[
            Container(
              height: getRelativeHeight(222),
              width: double.infinity,
              decoration: BoxDecoration(
                color: theme.graphite,
                borderRadius: BorderRadius.circular(4),
              ),
              child: (controller.newPositionService.canSelectPRiceRange.value &&
                      !controller.newPositionService.fetchingPoolData.value)
                  ? Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Select price range',
                              style: FondueSwapConstants.fromColor(
                                theme.mistyLavender,
                              ).kRoboto14,
                            ),
                          ),
                        ),
                        Text(
                          'Current price: ${controller.getPriceText()}',
                          style:
                              FondueSwapConstants.fromColor(theme.mistyLavender)
                                  .kRoboto14,
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 24),
                          child: SizedBox(
                            child: SfRangeSliderTheme(
                              data: SfRangeSliderThemeData(
                                activeLabelStyle: FondueSwapConstants.fromColor(
                                  theme.mistyLavender,
                                ).kRoboto14,
                                inactiveLabelStyle:
                                    FondueSwapConstants.fromColor(
                                  theme.mistyLavender,
                                ).kRoboto14,
                              ),
                              child: SfRangeSlider(
                                stepSize: controller.getStepSize(),
                                enableTooltip: true,
                                //initialValues: controller.rangeValues,
                                values: controller.rangeValues.value,
                                onChanged: (SfRangeValues values) {
                                  controller.rangeValues.value = values;
                                },
                                activeColor: theme.mistyLavender,
                                min: controller.sliderMin.value,
                                max: controller.sliderMax.value,
                                onChangeEnd:
                                    controller.updatePriceRangeFromChart,
                                showLabels: true,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Padding(
                      padding: EdgeInsets.only(
                        left: getRelativeWidth(12),
                        right: getRelativeWidth(12),
                        top: getRelativeHeight(12),
                        bottom: getRelativeHeight(24),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Select price range',
                              style: FondueSwapConstants.fromColor(
                                theme.mistyLavender,
                              ).kRoboto14,
                            ),
                          ),
                          Center(
                            child: (controller
                                    .newPositionService.fetchingPoolData.value)
                                ? Text(
                                    'Fetching pool data...',
                                    style: FondueSwapConstants.fromColor(
                                      theme.mistyLavender,
                                    ).kRoboto16,
                                  )
                                : Text(
                                    'Your position will appear here',
                                    style: FondueSwapConstants.fromColor(
                                      theme.mistyLavender,
                                    ).kRoboto16,
                                  ),
                          ),
                          const SizedBox(),
                        ],
                      ),
                    ),
            ),
            const SizedBox(height: 8),
            Row(
              children: <Widget>[
                Expanded(
                  child: PriceRangeTextFieldBox(
                    lable: 'Min price',
                    increase: () {
                      controller.increaseMinPrice();
                    },
                    decrease: () {
                      controller.decreaseMinPrice();
                    },
                    controller: controller.minPriceController,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: PriceRangeTextFieldBox(
                    lable: 'Max price',
                    increase: () {
                      controller.increaseMaxPrice();
                    },
                    decrease: () {
                      controller.decreaseMaxPrice();
                    },
                    controller: controller.maxPriceController,
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.graphite,
                minimumSize: const Size(double.infinity, 40),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(4),
                  ),
                ),
              ),
              child: Text(
                'Full range',
                style: FondueSwapConstants.fromColor(theme.mistyLavender)
                    .kRoboto14,
              ),
            ),
          ],
        );
      },
    );
  }
}
