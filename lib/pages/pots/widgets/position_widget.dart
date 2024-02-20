import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/position.dart';
import '../../../services/theme_service.dart';
import '../../../theme/constants.dart';
import '../../../theme/custom_theme.dart';
import '../../../utils/util.dart';

class PositionWidget extends StatelessWidget {
  const PositionWidget({required this.position, super.key});
  final Position position;

  @override
  Widget build(BuildContext context) {
    final FondueSwapTheme theme = Get.put(ThemeService()).fondueSwapTheme;
    return Container(
      padding: EdgeInsets.all(
        getRelativeWidth(24),
      ),
      width: double.infinity,
      decoration: BoxDecoration(
        color: theme.graphite,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                '${position.pool.token0.abbreviation}/${position.pool.token1.abbreviation}',
                textAlign: TextAlign.center,
                style: FondueSwapConstants.fromColor(theme.mistyLavender)
                    .kRoboto16,
              ),
              const Spacer(),
              Text(
                'Liquidity provided: ${position.liquidity}',
                textAlign: TextAlign.center,
                style: FondueSwapConstants.fromColor(theme.mistyLavender)
                    .kRoboto16,
              ),
            ],
          ),
          SizedBox(
            height: getRelativeHeight(16),
          ),
          Row(
            children: <Widget>[
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
                  style: FondueSwapConstants.fromColor(theme.goldenSunset)
                      .kRoboto16,
                ),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
