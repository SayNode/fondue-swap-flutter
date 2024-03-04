import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../services/theme_service.dart';
import '../../theme/constants.dart';
import '../../theme/custom_theme.dart';
import '../../utils/util.dart';
import '../../widgets/fondue_button.dart';
import '../../widgets/fondue_scaffold.dart';
import '../home/widgets/home_appbar.dart';
import 'controller/new_position_controller.dart';
import 'widgets/fee_selection_widget/fee_selection_widget.dart';
import 'widgets/price_range_welector_widget/price_range_selector_widget.dart';
import 'widgets/price_range_welector_widget/token_amount_textfield.dart';
import 'widgets/select_token_widget/select_token_widget.dart';
import 'widgets/slippage_slider_new_position/slippage_slider_new_position.dart';

class NewPositionPage extends GetView<NewPositionController> {
  const NewPositionPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(NewPositionController());
    final FondueSwapTheme theme = Get.put(ThemeService()).fondueSwapTheme;
    return FondueScaffold(
      appBar: const HomeAppbar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Select pair',
              style:
                  FondueSwapConstants.fromColor(theme.mistyLavender).kRoboto16,
            ),
            const SelectTokenWidget(),
            SizedBox(
              height: getRelativeHeight(16),
            ),
            const FeeSelectionWidget(),
            SizedBox(
              height: getRelativeHeight(16),
            ),
            const PriceRangeSelectorWidget(),
            SizedBox(
              height: getRelativeHeight(16),
            ),
            Text(
              'Deposit amount',
              style:
                  FondueSwapConstants.fromColor(theme.mistyLavender).kRoboto16,
            ),
            const SizedBox(
              height: 8,
            ),
            Obx(
              () {
                return TokenAmountTextField(
                  readOnly: controller.lockTokenXInput.value,
                  token: controller.newPositionService.tokenX.value,
                  controller: controller.tokenXAmountController,
                  onChanged: (String value) async {
                    if (double.tryParse(value) != null) {
                      controller.newPositionService.tokenXAmount.value =
                          double.parse(value);
                      controller.newPositionService.tokenYAmount.value =
                          await controller.getTokenY();
                      controller.tokenYAmountController.text = controller
                          .newPositionService.tokenYAmount.value
                          .toString();
                    } else {
                      controller.newPositionService.tokenXAmount.value = 0.0;
                      controller.tokenYAmountController.text = '';
                    }
                  },
                );
              },
            ),
            SizedBox(
              height: getRelativeHeight(16),
            ),
            Obx(
              () {
                return TokenAmountTextField(
                  readOnly: controller.lockTokenYInput.value,
                  token: controller.newPositionService.tokenY.value,
                  controller: controller.tokenYAmountController,
                  onChanged: (String value) async {
                    if (double.tryParse(value) != null) {
                      controller.newPositionService.tokenYAmount.value =
                          double.parse(value);
                      debugPrint('tokenXAmount: $value');
                      controller.newPositionService.tokenXAmount.value =
                          await controller.getTokenX();
                      controller.tokenXAmountController.text = controller
                          .newPositionService.tokenXAmount.value
                          .toString();
                    } else {
                      controller.newPositionService.tokenYAmount.value = 0.0;
                      controller.tokenYAmountController.text = '';
                    }
                  },
                );
              },
            ),
            SizedBox(
              height: getRelativeHeight(16),
            ),
            const SlippageSliderNewPosition(),
            SizedBox(
              height: getRelativeHeight(16),
            ),
            Obx(
              () {
                return FondueButton(
                  text: 'Pool now',
                  onTap: controller.createNewPosition,
                  disabled: !controller
                          .newPositionService.canSelectPRiceRange.value ||
                      controller.newPositionService.fetchingPoolData.value,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
