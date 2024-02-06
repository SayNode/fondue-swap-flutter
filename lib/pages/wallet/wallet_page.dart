import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/wallet.dart';
import '../../services/theme_service.dart';
import '../../services/wallet_service.dart';
import '../../theme/constants.dart';
import '../../theme/custom_theme.dart';
import '../../widgets/circle_button.dart';
import 'controllers/add_wallet_controller.dart';

class WalletPage extends GetView<AddWalletController> {
  const WalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    final FondueSwapTheme theme = Get.put(ThemeService()).fondueSwapTheme;
    final Wallet? wallet = Get.find<WalletService>().wallet.value;
    Get.put(AddWalletController());
    return (wallet != null)
        ? const Column()
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
          );
  }
}
