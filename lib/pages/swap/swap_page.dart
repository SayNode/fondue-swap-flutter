import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/wallet.dart';
import '../../services/wallet_service.dart';
import '../../utils/util.dart';
import '../../widgets/fondue_button.dart';
import '../pots/widgets/add_wallet_widget.dart';
import 'controller/swap_controller.dart';
import 'widget/price_widget/price_widget.dart';
import 'widget/slippage_slider/slippage_slider.dart';
import 'widget/swap_widget.dart';

class SwapPage extends GetView<SwapController> {
  const SwapPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SwapController());
    final Wallet? wallet = Get.find<WalletService>().wallet.value;
    return (wallet == null)
        ? const AddWalletWidget()
        : Obx(
            () {
              return Column(
                children: <Widget>[
                  const SwapWidget(),
                  if (controller.errorMessage.value.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        controller.errorMessage.value,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: getRelativeHeight(12),
                        ),
                      ),
                    ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: PriceWidget(),
                  ),
                  SizedBox(height: getRelativeHeight(16)),
                  const SlippageSlider(),
                  const Spacer(),
                  FondueButton(
                    text: 'Swap now',
                    disabled: !controller.gotQuote.value,
                    onTap: () async {
                      await controller.swap();
                    },
                  ),
                  SizedBox(height: getRelativeHeight(30)),
                ],
              );
            },
          );
  }
}
