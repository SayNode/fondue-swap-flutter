import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../services/theme_service.dart';
import '../../../theme/constants.dart';
import '../../../theme/custom_theme.dart';

class SwapCard extends StatelessWidget {
  const SwapCard({
    required this.title,
    required this.value,
    required this.buttonLable,
    super.key,
    this.onPressed,
  });

  final String title;
  final String value;
  final String buttonLable;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final FondueSwapTheme theme = Get.put(ThemeService()).fondueSwapTheme;
    return Container(
      padding: const EdgeInsets.only(
        left: 12,
        right: 12,
        top: 12,
        bottom: 24,
      ),
      width: double.infinity,
      decoration: BoxDecoration(
        color: theme.graphite,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            title,
            style: FondueSwapConstants.fromColor(theme.mistyLavender).kRoboto14,
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                value,
                style: FondueSwapConstants.fromColor(theme.mistyLavender)
                    .kRoboto22,
              ),
              const Spacer(),
              TextButton(
                onPressed: onPressed,
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  alignment: Alignment.centerLeft,
                ),
                child: Row(
                  children: <Widget>[
                    Text(
                      buttonLable,
                      style: FondueSwapConstants.fromColor(theme.mistyLavender)
                          .kRoboto16,
                    ),
                    Icon(
                      Icons.keyboard_arrow_down,
                      color: theme.goldenSunset,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
