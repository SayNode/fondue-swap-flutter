import 'package:flutter/material.dart';
import 'package:fondue_swap/pages/wallet/controllers/add_wallet_controller.dart';
import 'package:fondue_swap/pages/wallet/widgets/loading_page.dart';
import 'package:fondue_swap/services/wallet_service.dart';
import 'package:fondue_swap/theme/constants.dart';
import 'package:fondue_swap/widgets/circle_button.dart';
import 'package:get/get.dart';

import '../../services/theme_service.dart';

class WalletPage extends GetView<AddWalletController> {
  const WalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Get.put(ThemeService()).fondueSwapTheme;
    var wallet = Get.find<WalletService>().wallet.value;
    Get.put(AddWalletController());
    return (wallet != null)
        ? const Column(
            children: [],
          )
        : Center(
            child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
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
              ElevatedButton(
                  onPressed: () {
                    LoadingPage.show();
                  },
                  child: const Text('debug')),
            ],
          ));
  }
}
