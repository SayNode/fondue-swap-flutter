import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../services/new_position_service.dart';
import '../../services/theme_service.dart';
import '../../services/wallet_service.dart';
import '../../theme/constants.dart';
import '../../theme/custom_theme.dart';
import '../../utils/util.dart';
import '../../widgets/circle_button.dart';
import '../wallet/controllers/add_wallet_controller.dart';
import 'controller/pots_page_controller.dart';
import 'new_position_page.dart';
import 'widgets/add_wallet_widget.dart';
import 'widgets/position_widget/position_widget.dart';

class PotsPage extends GetView<PotsPageController> {
  const PotsPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(PotsPageController());
    final FondueSwapTheme theme = Get.put(ThemeService()).fondueSwapTheme;

    Get.put(AddWalletController());
    return Obx(
      () => (Get.find<WalletService>().wallet.value == null)
          ? const AddWalletWidget()
          : SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(
                    height: getRelativeHeight(64),
                  ),
                  CircleButton(
                    onPressed: () {
                      Get
                        ..put(NewPositionService()).clearService()
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
                  Obx(
                    () {
                      if (controller.positionService.positionList.isNotEmpty) {
                        return Column(
                          children: List<Widget>.generate(
                            controller.positionService.positionList.length,
                            (int index) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: PositionWidget(
                                position: controller
                                    .positionService.positionList[index],
                              ),
                            ),
                          ),
                        );
                      } else {
                        return Container(
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
                            style: FondueSwapConstants.fromColor(
                                    theme.mistyLavender)
                                .kRoboto16,
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
