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
    return Column(
      children: <Widget>[
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: theme.graphite,
            borderRadius: BorderRadius.circular(4),
          ),
          child: (!controller.canSelectPRiceRange.value)
              ? Padding(
                  padding: EdgeInsets.only(
                    left: getRelativeWidth(12),
                    right: getRelativeWidth(12),
                    top: getRelativeHeight(12),
                    bottom: getRelativeHeight(24),
                  ),
                  child: Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Select price range',
                          style:
                              FondueSwapConstants.fromColor(theme.mistyLavender)
                                  .kRoboto14,
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            'Your position will appear here',
                            style: FondueSwapConstants.fromColor(
                              theme.mistyLavender,
                            ).kRoboto16,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Select price range',
                          style:
                              FondueSwapConstants.fromColor(theme.mistyLavender)
                                  .kRoboto14,
                        ),
                      ),
                    ),
                    Text(
                      'Current price:',
                      style: FondueSwapConstants.fromColor(theme.mistyLavender)
                          .kRoboto14,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: SizedBox(
                        height: getRelativeHeight(200),
                        child: SfRangeSelectorTheme(
                          data: SfRangeSelectorThemeData(
                            activeLabelStyle: FondueSwapConstants.fromColor(
                              theme.mistyLavender,
                            ).kRoboto14,
                            inactiveLabelStyle: FondueSwapConstants.fromColor(
                              theme.mistyLavender,
                            ).kRoboto14,
                          ),
                          child: SfRangeSelector(
                            enableTooltip: true,
                            initialValues: controller.rangeValues,
                            activeColor: theme.mistyLavender,
                            min: 2,
                            max: 10,
                            onChangeEnd: print,
                            showLabels: true,
                            child: controller.buildChart(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        ),
        const SizedBox(height: 8),
        Row(
          children: <Widget>[
            Expanded(
              child: PriceRangeTextFieldBox(
                lable: 'Min price',
                increase: () {},
                decrease: () {},
                controller: TextEditingController(),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: PriceRangeTextFieldBox(
                lable: 'Max price',
                increase: () {},
                decrease: () {},
                controller: TextEditingController(),
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
            style: FondueSwapConstants.fromColor(theme.mistyLavender).kRoboto14,
          ),
        ),
      ],
    );
  }
}
