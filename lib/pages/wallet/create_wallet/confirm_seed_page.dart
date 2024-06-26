import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../services/theme_service.dart';
import '../../../theme/constants.dart';
import '../../../theme/custom_theme.dart';
import '../../../widgets/fondue_appbar.dart';
import '../../../widgets/fondue_button.dart';
import '../../../widgets/fondue_scaffold.dart';
import 'controllers/seed_controller.dart';

class ConfirmSeedPage extends GetView<SeedController> {
  const ConfirmSeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final FondueSwapTheme theme = Get.put(ThemeService()).fondueSwapTheme;

    return FondueScaffold(
      appBar: FondueAppbar(title: 'Seed phrases'.tr),
      body: Center(
        child: Column(
          children: <Widget>[
            Text(
              'Verify your seed phrase',
              style:
                  FondueSwapConstants.fromColor(theme.mistyLavender).kRoboto22,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              'To enhance the accuracy and security of your seed phrase, please put the phrase in the correct order',
              style:
                  FondueSwapConstants.fromColor(theme.mistyLavender).kRoboto14,
            ),
            const SizedBox(
              height: 84,
            ),
            Obx(
              () => controller.buildDynamicList(
                controller.confirmedWords,
                confirmedList: true,
                notify: controller.rebuildLists.value,
              ),
            ),
            Divider(
              color: theme.mistyLavender,
            ),
            Obx(
              () => controller.buildDynamicList(
                controller.unconfirmedWords,
                confirmedList: false,
                notify: controller.rebuildLists.value,
              ),
            ),
            Obx(
              () => controller.wrongOrder.value
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            SvgPicture.asset(
                              'assets/icons/exclamation_mark.svg',
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.02,
                            ),
                            Text(
                              'Words in wrong order'.tr,
                              style:
                                  FondueSwapConstants.fromColor(theme.cherryRed)
                                      .kRoboto14,
                            ),
                          ],
                        ),
                      ],
                    )
                  : Container(),
            ),
            const Spacer(),
            Obx(
              () => FondueButton(
                disabled: !controller.checkIfAllWordsOrdered(
                  notify: controller.rebuildLists.value,
                ),
                expanded: true,
                text: 'Confirm',
                onTap: () => <void>{controller.submit()},
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
          ],
        ),
      ),
    );
  }
}
