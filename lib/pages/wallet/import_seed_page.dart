import 'package:flutter/material.dart';
import 'package:fondue_swap/pages/wallet/widgets/seed_phrase_textfield.dart';
import 'package:fondue_swap/theme/constants.dart';
import 'package:fondue_swap/widgets/fondue_appbar.dart';
import 'package:fondue_swap/widgets/fondue_scaffold.dart';
import 'package:get/get.dart';

import '../../services/theme_service.dart';
import '../../widgets/new_fondue_button.dart';
import 'controllers/import_seed_controller.dart';

class ImportSeedPage extends GetView<ImportSeedController> {
  const ImportSeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Get.put(ThemeService()).fondueSwapTheme;
    Get.put(ImportSeedController());
    //double width = MediaQuery.of(context).size.height;
    //print(width / 2.25);
    return FondueScaffold(
      appBar: FondueAppbar(title: 'Import seed phrase'.tr),
      body: Center(
        child: Column(
          children: [
            Text(
              'Add wallet using seeds',
              style: FondueSwapConstants.fromColor(theme.mistyLavender).kRoboto22,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              'Import your wallet by entering seed phrases',
              style: FondueSwapConstants.fromColor(theme.mistyLavender).kRoboto14,
            ),
            const SizedBox(
              height: 84,
            ),
            SeedPhraseTextField(
              controller: controller.seedPhraseController,
              onChanged: controller.onChangedSeedPhraseTextField,
              //onSubmitted: (p0) => controller.submit(),
            ),
            const Spacer(),
            Obx(() {
              return NewFondueButton(
                disabled: controller.buttonDisabled.value,
                expanded: true,
                text: 'Add wallet',
                onTap: () => controller.submit(),
              );
            }),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.08,
            ),
          ],
        ),
      ),
    );
  }
}
