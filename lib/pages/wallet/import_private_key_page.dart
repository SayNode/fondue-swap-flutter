import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../services/theme_service.dart';
import '../../theme/constants.dart';
import '../../widgets/fondue_appbar.dart';
import '../../widgets/fondue_button.dart';
import '../../widgets/fondue_scaffold.dart';
import '../../widgets/fondue_textfield.dart';
import 'controllers/import_private_key_controller.dart';

class ImportPrivateKeyPage extends GetView<ImportPrivateKeyController> {
  const ImportPrivateKeyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Get.put(ThemeService()).fondueSwapTheme;
    Get.put(ImportPrivateKeyController());

    return FondueScaffold(
      appBar: FondueAppbar(title: 'Import Private key'.tr),
      body: Center(
        child: Column(
          children: [
            Text(
              'Add wallet using private key',
              style: FondueSwapConstants.fromColor(theme.mistyLavender).kRoboto22,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              'Import your wallet by providing private key',
              style: FondueSwapConstants.fromColor(theme.mistyLavender).kRoboto14,
            ),
            const SizedBox(
              height: 84,
            ),
            FondueTextField(
              controller: controller.privateKeyController,
              hintText: 'Enter your private key',
            ),
            const SizedBox(
              height: 10,
            ),
            Obx(
              () => controller.invalidPrivateKey.value
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
