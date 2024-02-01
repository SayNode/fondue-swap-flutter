import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../services/theme_service.dart';
import '../../../theme/constants.dart';
import '../../../theme/custom_theme.dart';

class SelectTokenBottomSheet extends StatelessWidget {
  const SelectTokenBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final FondueSwapTheme theme = Get.put(ThemeService()).fondueSwapTheme;
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: BoxDecoration(
        color: theme.midnightBlack,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(4),
          topRight: Radius.circular(4),
        ),
        border: Border.all(
          color: theme.mistyLavender,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  'Modal BottomSheet',
                  style: FondueSwapConstants.fromColor(theme.mistyLavender)
                      .kRoboto16,
                ),
                const Spacer(),
                IconButton(
                  onPressed: () => Get.back<Widget>(),
                  icon: Icon(
                    Icons.close,
                    color: theme.mistyLavender,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Divider(
                color: theme.graphite,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
