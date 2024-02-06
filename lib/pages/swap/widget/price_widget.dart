import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../services/theme_service.dart';
import '../../../theme/constants.dart';
import '../../../theme/custom_theme.dart';

class PriceWidget extends StatelessWidget {
  const PriceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final FondueSwapTheme theme = Get.put(ThemeService()).fondueSwapTheme;
    //final SwapService swapService = Get.find<SwapService>();
    return Container(
      padding: const EdgeInsets.all(
        12,
      ),
      width: double.infinity,
      decoration: BoxDecoration(
        color: theme.graphite,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: <Widget>[
          Text(
            'Fetching best price.....',
            style: FondueSwapConstants.fromColor(theme.mistyLavender).kRoboto14,
          ),
        ],
      ),
    );
  }
}
