import 'package:flutter/material.dart';
import '../controllers/home_controller.dart';
import 'package:get/get.dart';

import '../../../models/wallet.dart';
import '../../../services/theme_service.dart';
import '../../../services/wallet_service.dart';
import '../../../theme/constants.dart';
import '../../../theme/custom_theme.dart';

class HomeAppbar extends GetView<HomeController>
    implements PreferredSizeWidget {
  const HomeAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    final FondueSwapTheme theme = Get.put(ThemeService()).fondueSwapTheme;
    final Wallet? wallet = Get.find<WalletService>().wallet.value;
    return AppBar(
      centerTitle: true,
      title: Obx(() {
        return (controller.titles[controller.selectedIndex.value] == 'Wallet' &&
                wallet != null)
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset('assets/images/grey_gold_wallet.png'),
                  Text(
                    'Wallet(${Get.find<WalletService>().wallet.value!.address.substring(0, 7)}...)',
                    style: FondueSwapConstants.fromColor(theme.mistyLavender)
                        .kRoboto14,
                  ),
                ],
              )
            : Text(
                controller.titles[controller.selectedIndex.value],
                style: FondueSwapConstants.fromColor(theme.mistyLavender)
                    .kRoboto14,
              );
      }),
      elevation: 0,
      backgroundColor: theme.midnightBlack,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
