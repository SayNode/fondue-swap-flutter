import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../../../services/theme_service.dart';
import '../../../../theme/constants.dart';
import '../../../../theme/custom_theme.dart';
import '../../../../utils/util.dart';
import 'controller/price_range_selector_controller.dart';

class PriceRangeSelectorWidget extends GetView<PriceRangeSelectorController> {
  const PriceRangeSelectorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(PriceRangeSelectorController());
    final FondueSwapTheme theme = Get.put(ThemeService()).fondueSwapTheme;
    return Container(
      padding: EdgeInsets.only(
        left: getRelativeWidth(12),
        right: getRelativeWidth(12),
        top: getRelativeHeight(12),
        bottom: getRelativeHeight(24),
      ),
      width: double.infinity,
      height: getRelativeHeight(231),
      decoration: BoxDecoration(
        color: theme.graphite,
        borderRadius: BorderRadius.circular(4),
      ),
      child: (!controller.canSelectPRiceRange.value)
          ? Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Select price range',
                    style: FondueSwapConstants.fromColor(theme.mistyLavender)
                        .kRoboto14,
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      'Your position will appear here',
                      style: FondueSwapConstants.fromColor(theme.mistyLavender)
                          .kRoboto16,
                    ),
                  ),
                ),
              ],
            )
          : SfRangeSelector(
              initialValues: controller.rangeValues,
              min: 2,
              max: 10,
              child: controller.buildChart(),
            ),
    );
  }
}
