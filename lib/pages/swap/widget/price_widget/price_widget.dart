import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../services/theme_service.dart';
import '../../../../theme/constants.dart';
import '../../../../theme/custom_theme.dart';
import 'price_widget_controller.dart';

class PriceWidget extends GetView<PricerWidgetController> {
  const PriceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final FondueSwapTheme theme = Get.put(ThemeService()).fondueSwapTheme;
    Get.put<PricerWidgetController>(PricerWidgetController());
    return Obx(
      () => (controller.showFetchingPrice.value)
          ? Container(
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
                  if (controller.swapService.gotQuote.value)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              '1 ${controller.swapService.tokenX.value!.abbreviation} = ${controller.swapService.amountY.value / controller.swapService.amountX.value} ${controller.swapService.tokenY.value!.abbreviation}',
                              style: FondueSwapConstants.fromColor(
                                theme.mistyLavender,
                              ).kRoboto14,
                            ),
                            const Spacer(),
                            IconButton(
                              onPressed: () => controller.expanded.value =
                                  !controller.expanded.value,
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Text(
                                    'Fees',
                                    style: FondueSwapConstants.fromColor(
                                      theme.mistyLavender,
                                    ).kRoboto14,
                                  ),
                                  const Spacer(),
                                  Text(
                                    '${(controller.swapService.poolFee / BigInt.from(10000)).toStringAsFixed(2)}%',
                                    style: FondueSwapConstants.fromColor(
                                      theme.mistyLavender,
                                    ).kRoboto14,
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Text(
                                    'Price Impact',
                                    style: FondueSwapConstants.fromColor(
                                      theme.mistyLavender,
                                    ).kRoboto14,
                                  ),
                                  const Spacer(),
                                  Text(
                                    '${controller.swapService.priceImpact.value.toStringAsFixed(2)}%',
                                    style: FondueSwapConstants.fromColor(
                                      theme.mistyLavender,
                                    ).kRoboto14,
                                  ),
                                ],
                              ),
                            ],
                          )
                        else
                          const SizedBox(),
                      ],
                    )
                  else
                    Row(
                      children: <Widget>[
                        Text(
                          'Fetching best price.....',
                          style:
                              FondueSwapConstants.fromColor(theme.mistyLavender)
                                  .kRoboto14,
                        ),
                      ],
                    ),
                ],
              ),
            )
          : const SizedBox(),
    );
  }
}
