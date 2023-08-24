import 'package:flutter/material.dart';
import 'package:fondue_swap/pages/wallet/create_wallet/seed_security_rules.dart';
import 'package:get/get.dart';

import '../../../services/theme_service.dart';
import '../../../theme/constants.dart';
import '../../../widgets/fondue_appbar.dart';
import '../../../widgets/fondue_button.dart';
import '../../../widgets/fondue_scaffold.dart';

class CreateWalletPage extends StatelessWidget {
  const CreateWalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Get.put(ThemeService()).fondueSwapTheme;

    return FondueScaffold(
      appBar: FondueAppbar(title: 'Create Wallet'.tr),
      body: Center(
        child: Column(
          children: [
            Text(
              'Create Wallet',
              style:
                  FondueSwapConstants.fromColor(theme.mistyLavender).kRoboto22,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              'Generate a new wallet address and seed phrases',
              style:
                  FondueSwapConstants.fromColor(theme.mistyLavender).kRoboto14,
            ),
            const SizedBox(
              height: 84,
            ),
            const Spacer(),
            FondueButton(
              disabled: false,
              expanded: true,
              text: 'Create wallet',
              onTap: () => {Get.to(() => const SeedSecurityRulesPage())},
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.08,
            ),
          ],
        ),
      ),
    );
  }
}
