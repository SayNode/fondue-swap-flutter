import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../models/position.dart';
import '../../../../services/theme_service.dart';
import '../../../../theme/constants.dart';
import '../../../../theme/custom_theme.dart';
import '../../../../utils/util.dart';
import 'controller/position_widget_controller.dart';

class PositionWidget extends GetView<PositionWidgetController> {
  const PositionWidget({required this.position, super.key});
  final Position position;

  @override
  Widget build(BuildContext context) {
    Get.put(PositionWidgetController());
    final FondueSwapTheme theme = Get.put(ThemeService()).fondueSwapTheme;
    final RxBool expanded = false.obs;
    return Container(
      padding: EdgeInsets.all(
        getRelativeWidth(24),
      ),
      width: double.infinity,
      decoration: BoxDecoration(
        color: theme.graphite,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Obx(
        () {
          return Column(
            children: <Widget>[
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  expanded.value = !expanded.value;
                },
                child: Row(
                  children: <Widget>[
                    Text(
                      '${position.pool.token0.abbreviation}/${position.pool.token1.abbreviation}',
                      textAlign: TextAlign.center,
                      style: FondueSwapConstants.fromColor(theme.mistyLavender)
                          .kRoboto16,
                    ),
                    const Spacer(),
                    // Text(
                    //   'Liquidity provided: ${position.liquidity}',
                    //   textAlign: TextAlign.center,
                    //   style: FondueSwapConstants.fromColor(theme.mistyLavender)
                    //       .kRoboto16,
                    // ),
                    Icon(
                      expanded.value
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: theme.mistyLavender,
                    ),
                  ],
                ),
              ),
              if (expanded.value)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Divider(
                      color: theme.mistyLavender,
                    ),
                    SizedBox(
                      height: getRelativeHeight(16),
                    ),
                    Text(
                      '${position.pool.token0.abbreviation} provided: ${roundWithMagnitude(position.tokenXProvided! / BigInt.from(10).pow(position.pool.token0.decimals), precision: 2)}',
                      textAlign: TextAlign.left,
                      style: FondueSwapConstants.fromColor(
                        theme.mistyLavender,
                      ).kRoboto16,
                    ),
                    Text(
                      '${position.pool.token1.abbreviation} provided: ${roundWithMagnitude(position.tokenYProvided! / BigInt.from(10).pow(position.pool.token1.decimals), precision: 2)}',
                      textAlign: TextAlign.left,
                      style: FondueSwapConstants.fromColor(
                        theme.mistyLavender,
                      ).kRoboto16,
                    ),
                    Text(
                      '${position.pool.token0.abbreviation} Fee: ${roundWithMagnitude(position.tkxFee! / BigInt.from(10).pow(position.pool.token1.decimals), precision: 2)}',
                      textAlign: TextAlign.left,
                      style: FondueSwapConstants.fromColor(
                        theme.mistyLavender,
                      ).kRoboto16,
                    ),
                    Text(
                      '${position.pool.token1.abbreviation} Fee: ${roundWithMagnitude(position.tkyFee! / BigInt.from(10).pow(position.pool.token1.decimals), precision: 2)}',
                      textAlign: TextAlign.left,
                      style: FondueSwapConstants.fromColor(
                        theme.mistyLavender,
                      ).kRoboto16,
                    ),
                    Text(
                      'Current Price: ${roundWithMagnitude(position.pool.currentPrice, precision: 2)} ${position.pool.token0.abbreviation}/${position.pool.token1.abbreviation}',
                      textAlign: TextAlign.left,
                      style: FondueSwapConstants.fromColor(
                        theme.mistyLavender,
                      ).kRoboto16,
                    ),
                    Text(
                      'Price range: ${roundWithMagnitude(position.minPrice)} - ${roundWithMagnitude(position.maxPrice)} ${position.pool.token0.abbreviation}/${position.pool.token1.abbreviation}',
                      textAlign: TextAlign.left,
                      style: FondueSwapConstants.fromColor(
                        theme.mistyLavender,
                      ).kRoboto16,
                    ),
                    Row(
                      children: <Widget>[
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            backgroundColor: Colors.transparent,
                            side: BorderSide(
                              color: theme.goldenSunset,
                            ),
                          ),
                          child: Text(
                            'Collect Fees',
                            textAlign: TextAlign.center,
                            style: FondueSwapConstants.fromColor(
                              theme.goldenSunset,
                            ).kRoboto16,
                          ),
                          onPressed: () async {
                            await controller.collectFees(position);
                          },
                        ),
                        const Spacer(),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            backgroundColor: Colors.transparent,
                            side: BorderSide(
                              color: theme.goldenSunset,
                            ),
                          ),
                          child: Text(
                            'Remove position',
                            textAlign: TextAlign.center,
                            style: FondueSwapConstants.fromColor(
                              theme.goldenSunset,
                            ).kRoboto16,
                          ),
                          onPressed: () async {
                            await controller.removePosition(position);
                          },
                        ),
                      ],
                    ),
                  ],
                )
              else
                const SizedBox(),
            ],
          );
        },
      ),
    );
  }
}
