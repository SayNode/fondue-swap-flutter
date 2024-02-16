import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/token.dart';
import '../../../services/theme_service.dart';
import '../../../theme/constants.dart';
import '../../../theme/custom_theme.dart';

class TokenTile extends StatelessWidget {
  const TokenTile({required this.token, required this.onTap, super.key});

  final Token token;

  final void Function(Token) onTap;

  @override
  Widget build(BuildContext context) {
    final FondueSwapTheme theme = Get.put(ThemeService()).fondueSwapTheme;
    return GestureDetector(
      onTap: () {
        onTap(token);
      },
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: ColoredBox(
          color: Colors.transparent,
          child: Row(
            children: <Widget>[
              Image.asset(token.icon, width: 25, height: 25),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    token.name,
                    style: FondueSwapConstants.fromColor(theme.mistyLavender)
                        .kRoboto14,
                  ),
                  Text(
                    token.abbreviation,
                    style: FondueSwapConstants.fromColor(theme.mistyLavender)
                        .kRoboto10,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
