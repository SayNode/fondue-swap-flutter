import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/wallet.dart';
import '../../services/new_position_service.dart';
import '../../services/theme_service.dart';
import '../../services/wallet_service.dart';
import '../../theme/constants.dart';
import '../../theme/custom_theme.dart';
import '../../utils/util.dart';
import '../../widgets/circle_button.dart';
import '../wallet/controllers/add_wallet_controller.dart';
import 'new_position_page.dart';
import 'widgets/add_wallet_widget.dart';

class PotsPage extends StatelessWidget {
  const PotsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final FondueSwapTheme theme = Get.put(ThemeService()).fondueSwapTheme;
    final Wallet? wallet = Get.find<WalletService>().wallet.value;
    Get.put(AddWalletController());
    return (wallet == null)
        ? const AddWalletWidget()
        : Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: getRelativeHeight(64),
              ),
              CircleButton(
                onPressed: () {
                  Get
                    ..put(NewPositionService())
                    ..to<Widget>(() => const NewPositionPage());
                },
                icon: 'assets/icons/add_icon.png',
              ),
              Text(
                'Add new position'.tr,
                style: FondueSwapConstants.fromColor(theme.mistyLavender)
                    .kRoboto14,
              ),
              SizedBox(
                height: getRelativeHeight(64),
              ),
              Container(
                padding: EdgeInsets.all(
                  getRelativeWidth(24),
                ),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: theme.graphite,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Your active liquidity position will appear here',
                  textAlign: TextAlign.center,
                  style: FondueSwapConstants.fromColor(theme.mistyLavender)
                      .kRoboto16,
                ),
              ),
            ],
          );
  }
}
