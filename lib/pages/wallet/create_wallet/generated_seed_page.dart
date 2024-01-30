import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../services/theme_service.dart';
import '../../../theme/constants.dart';
import '../../../theme/custom_theme.dart';
import '../../../widgets/fondue_appbar.dart';
import '../../../widgets/fondue_button.dart';
import '../../../widgets/fondue_scaffold.dart';
import 'confirm_seed_page.dart';
import 'controllers/seed_controller.dart';

class GeneratedSeedPage extends GetView<SeedController> {
  const GeneratedSeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final FondueSwapTheme theme = Get.put(ThemeService()).fondueSwapTheme;
    Get.put(SeedController());

    return FondueScaffold(
      appBar: FondueAppbar(title: 'Seed phrases'.tr),
      body: Center(
        child: Column(
          children: <Widget>[
            Text(
              'Write down your seed phrase',
              style:
                  FondueSwapConstants.fromColor(theme.mistyLavender).kRoboto22,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              'Critical step: record your deed phrase on paper',
              style:
                  FondueSwapConstants.fromColor(theme.mistyLavender).kRoboto14,
            ),
            const SizedBox(
              height: 84,
            ),
            controller.buildStaticSeedGrid(),
            const Spacer(),
            FondueButton(
              expanded: true,
              text: 'Next',
              onTap: () =>
                  <Future<dynamic>?>{Get.off(() => const ConfirmSeedPage())},
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
