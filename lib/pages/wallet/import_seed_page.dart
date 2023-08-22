import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fondue_swap/pages/wallet/widgets/seed_phrase_textfield.dart';
import 'package:fondue_swap/theme/constants.dart';
import 'package:fondue_swap/widgets/fondue_appbar.dart';
import 'package:fondue_swap/widgets/fondue_scaffold.dart';
import 'package:get/get.dart';

import '../../services/theme_service.dart';
import '../../widgets/fondue_button.dart';
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
            const SizedBox(
              height: 10,
            ),
            Obx(
              () => controller.invalidSeed.value
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset('assets/icons/exclamation_mark.svg'),
                            SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                            Text(
                              'Invalid Seed phrase'.tr,
                              style: FondueSwapConstants.fromColor(theme.cherryRed).kRoboto14,
                            ),
                          ],
                        ),
                      ],
                    )
                  : Container(),
            ),
            const Spacer(),
            Obx(() {
              return FondueButton(
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
