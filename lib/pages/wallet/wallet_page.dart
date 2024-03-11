import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../services/theme_service.dart';
import '../../services/wallet_service.dart';
import '../../theme/constants.dart';
import '../../theme/custom_theme.dart';
import '../../widgets/circle_button.dart';
import 'controllers/add_wallet_controller.dart';
import 'widgets/token_list_widget.dart';

class WalletPage extends GetView<AddWalletController> {
  const WalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    final FondueSwapTheme theme = Get.put(ThemeService()).fondueSwapTheme;
    Get.put(AddWalletController());
    return Obx(
      () => (Get.find<WalletService>().wallet.value != null)
          ? const TokenListWidget()
          : Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  CircleButton(
                    onPressed: () {
                      controller.choseAddWalletOptions();
                    },
                    icon: 'assets/icons/add_icon.png',
                  ),
                  Text(
                    'Add wallet'.tr,
                    style: FondueSwapConstants.fromColor(theme.mistyLavender)
                        .kRoboto14,
                  ),
                ],
              ),
            ),
    );
  }
}
