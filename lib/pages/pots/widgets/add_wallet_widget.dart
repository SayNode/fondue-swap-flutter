import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../services/theme_service.dart';
import '../../../theme/constants.dart';
import '../../../theme/custom_theme.dart';
import '../../../utils/util.dart';
import '../../../widgets/circle_button.dart';
import '../../wallet/controllers/add_wallet_controller.dart';

class AddWalletWidget extends StatelessWidget {
  const AddWalletWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final FondueSwapTheme theme = Get.put(ThemeService()).fondueSwapTheme;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          CircleButton(
            onPressed: () =>
                Get.put(AddWalletController()).choseAddWalletOptions(),
            icon: 'assets/icons/add_icon.png',
          ),
          Text(
            'Add wallet'.tr,
            style: FondueSwapConstants.fromColor(theme.mistyLavender).kRoboto14,
          ),
          SizedBox(
            height: getRelativeHeight(64),
          ),
          Container(
            padding: EdgeInsets.all(
              getRelativeWidth(30),
            ),
            width: double.infinity,
            decoration: BoxDecoration(
              color: theme.graphite,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: <Widget>[
                Text(
                  'Please connect your wallet',
                  style: FondueSwapConstants.fromColor(theme.mistyLavender)
                      .kRoboto22,
                ),
                SizedBox(
                  height: getRelativeHeight(20),
                ),
                Text(
                  "To start swapping and accessing our platform's features, you need to connect a wallet",
                  textAlign: TextAlign.center,
                  style: FondueSwapConstants.fromColor(theme.mistyLavender)
                      .kRoboto16,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
