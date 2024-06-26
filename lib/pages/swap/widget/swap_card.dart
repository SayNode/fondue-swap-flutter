import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../services/swap_service.dart';
import '../../../services/theme_service.dart';
import '../../../theme/constants.dart';
import '../../../theme/custom_theme.dart';
import '../../../utils/util.dart';

class SwapCard extends StatelessWidget {
  const SwapCard({
    required this.title,
    required this.value,
    required this.buttonLable,
    required this.textController,
    required this.enabled,
    super.key,
    this.onPressed,
  });

  final String title;
  final String value;
  final String buttonLable;
  final TextEditingController textController;
  final bool enabled;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final FondueSwapTheme theme = Get.put(ThemeService()).fondueSwapTheme;
    final SwapService swapService = Get.find<SwapService>();
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
              SizedBox(
                width: getRelativeWidth(200),
                child: TextField(
                  enabled: enabled,
                  controller: textController,
                  decoration: InputDecoration.collapsed(
                    hintText: '0.0',
                    hintStyle:
                        FondueSwapConstants.fromColor(theme.mistyLavender)
                            .kRoboto22,
                  ),
                  style: FondueSwapConstants.fromColor(theme.mistyLavender)
                      .kRoboto22,
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: (swapService.fetchingPrice.value) ? null : onPressed,
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
