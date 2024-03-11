import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/token.dart';
import '../../../services/theme_service.dart';
import '../../../theme/constants.dart';
import '../../../theme/custom_theme.dart';
import '../../../utils/util.dart';

class TokenListTile extends StatelessWidget {
  const TokenListTile({required this.token, super.key});
  final Token token;

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
      child: Obx(
        () => Row(
          children: <Widget>[
            Image.asset(
              token.icon,
              width: 24,
              height: 24,
            ),
            const SizedBox(
              width: 16,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  token.abbreviation,
                  style: FondueSwapConstants.fromColor(theme.mistyLavender)
                      .kRoboto14,
                ),
                Text(
                  token.name,
                  style: FondueSwapConstants.fromColor(theme.mistyLavender)
                      .kRoboto12,
                ),
              ],
            ),
            const Spacer(),
            if (token.balance.value == null)
              const Center(child: CircularProgressIndicator())
            else
              Text(
                roundWithMagnitude(
                  token.balance.value! / BigInt.from(10).pow(token.decimals),
                ).toString(),
                style: FondueSwapConstants.fromColor(theme.mistyLavender)
                    .kRoboto14,
              ),
          ],
        ),
      ),
    );
  }
}
