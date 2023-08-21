import 'package:flutter/material.dart';
import 'package:fondue_swap/pages/wallet/controllers/add_wallet_controller.dart';
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
    Get.put(AddWalletController());
    return Center(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          Get.find<WalletService>().wallet.value!.address,
          style: const TextStyle(color: Colors.green),
        ),
        CircleButton(
          onPressed: () {
            controller.choseAddWalletOptions();
          },
          icon: 'assets/icons/add_icon.png',
        ),
        Text(
          'Add wallet'.tr,
          style: FondueSwapConstants.fromColor(theme.mistyLavender).kRoboto14,
        ),
      ],
    ));
  }
}
