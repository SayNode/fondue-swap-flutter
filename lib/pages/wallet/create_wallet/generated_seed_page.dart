import 'package:flutter/material.dart';
import 'package:fondue_swap/pages/wallet/create_wallet/confirm_seed_page.dart';
import 'package:fondue_swap/pages/wallet/create_wallet/controllers/seed_controller.dart';
import 'package:get/get.dart';

import '../../../services/theme_service.dart';
import '../../../theme/constants.dart';
import '../../../widgets/fondue_appbar.dart';
import '../../../widgets/fondue_button.dart';
import '../../../widgets/fondue_scaffold.dart';

class GeneratedSeedPage extends GetView<SeedController> {
  const GeneratedSeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Get.put(ThemeService()).fondueSwapTheme;
    Get.put(SeedController());

    return FondueScaffold(
      appBar: FondueAppbar(title: 'Seed phrases'.tr),
      body: Center(
        child: Column(
          children: [
            Text(
              'Write down your seed phrase',
              style: FondueSwapConstants.fromColor(theme.mistyLavender).kRoboto22,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              'Critical step: record your deed phrase on paper',
              style: FondueSwapConstants.fromColor(theme.mistyLavender).kRoboto14,
            ),
            const SizedBox(
              height: 84,
            ),
            controller.buildStaticSeedGrid(),
            const Spacer(),
            FondueButton(
              disabled: false,
              expanded: true,
              text: 'Next',
              onTap: () => {
                Get.off(() => const ConfirmSeedPage())
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
