import 'package:flutter/material.dart';
import 'package:fondue_swap/theme/constants.dart';
import 'package:fondue_swap/widgets/fondue_button.dart';
import 'package:get/get.dart';

import '../../services/theme_service.dart';

class WalletAddedPage extends StatelessWidget {
  const WalletAddedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Get.put(ThemeService()).fondueSwapTheme;
    return SimpleDialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      contentPadding: const EdgeInsets.all(30),
      backgroundColor: theme.graphite,
      children: <Widget>[
        Row(
          children: [
            const Spacer(),
            IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              onPressed: () => Get.close(2),
              icon: Icon(
                Icons.close,
                color: theme.mistyLavender,
                size: 23,
              ),
            )
          ],
        ),
        const SizedBox(height: 28),
        Center(
          child: Text(
            'Wallet Added',
            style: FondueSwapConstants.fromColor(theme.mistyLavender).kRoboto22,
          ),
        ),
        const SizedBox(height: 20),
        Image.asset(
          'assets/images/tick-circle.png',
          width: 100,
          height: 100,
        ),
        const SizedBox(height: 20),
        Center(
          child: Text(
            "Congratulations on successfully adding your wallet to our app. You can now securely manage your funds and enjoy all our app's features.",
            textAlign: TextAlign.center,
            style: FondueSwapConstants.fromColor(theme.mistyLavender).kRoboto14,
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(),
            FondueButton(
              text: 'Done',
              onTap: () => Get.close(2),
              width: 151,
            ),
            const SizedBox(),
          ],
        ),
      ],
    );
  }
}
