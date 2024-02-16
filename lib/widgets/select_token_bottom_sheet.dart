import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/token.dart';
import '../pages/swap/widget/token_tile.dart';
import '../services/theme_service.dart';
import '../services/token_service.dart';
import '../theme/constants.dart';
import '../theme/custom_theme.dart';

class SelectTokenBottomSheet extends StatelessWidget {
  const SelectTokenBottomSheet({required this.onTokenPressed, super.key});

  final void Function(Token) onTokenPressed;

  @override
  Widget build(BuildContext context) {
    final FondueSwapTheme theme = Get.put(ThemeService()).fondueSwapTheme;
    final List<Token> tokenList = Get.find<TokenService>().tokensList;
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
                  'Select a token',
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
            Column(
              children: <Widget>[
                for (final Token token in tokenList)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: TokenTile(
                      token: token,
                      onTap: onTokenPressed,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
