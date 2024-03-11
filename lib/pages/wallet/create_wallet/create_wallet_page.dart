import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../services/theme_service.dart';
import '../../../theme/constants.dart';
import '../../../theme/custom_theme.dart';
import '../../../widgets/fondue_appbar.dart';
import '../../../widgets/fondue_button.dart';
import '../../../widgets/fondue_scaffold.dart';
import 'seed_security_rules.dart';

class CreateWalletPage extends StatelessWidget {
  const CreateWalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    final FondueSwapTheme theme = Get.put(ThemeService()).fondueSwapTheme;

    return FondueScaffold(
      appBar: FondueAppbar(title: 'Create Wallet'.tr),
      body: Center(
        child: Column(
          children: <Widget>[
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
              expanded: true,
              text: 'Create wallet',
              onTap: () => <Future<dynamic>?>{
                Get.to(() => const SeedSecurityRulesPage()),
              },
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
