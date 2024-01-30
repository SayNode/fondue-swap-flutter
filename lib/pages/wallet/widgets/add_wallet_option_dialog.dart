import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../services/theme_service.dart';
import '../../../theme/custom_theme.dart';
import '../../../utils/add_wallet_options.dart';
import 'popup_button.dart';

class AddWalletOptionsDialog extends StatelessWidget {
  const AddWalletOptionsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final FondueSwapTheme theme = Get.put(ThemeService()).fondueSwapTheme;
    return SimpleDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      contentPadding: const EdgeInsets.all(30),
      backgroundColor: theme.graphite,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Spacer(),
            IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              onPressed: Get.back<Widget>,
              icon: Icon(
                Icons.close,
                color: theme.mistyLavender,
                size: 23,
              ),
            ),
          ],
        ),
        const SizedBox(height: 28),
        PopupButton(
          text: 'Add wallet using seed',
          onPressed: () {
            Navigator.pop(context, AddWalletOptions.importSeed);
          },
        ),
        const SizedBox(height: 25),
        PopupButton(
          text: 'Add wallet using private key',
          onPressed: () {
            Navigator.pop(context, AddWalletOptions.importPrivateKey);
          },
        ),
        const SizedBox(height: 25),
        PopupButton(
          text: 'Create Wallet',
          onPressed: () {
            Navigator.pop(context, AddWalletOptions.createWallet);
          },
        ),
      ],
    );
  }
}
