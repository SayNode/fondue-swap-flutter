import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/util.dart';
import '../../widgets/fondue_button.dart';
import 'controller/swap_controller.dart';
import 'widget/price_widget.dart';
import 'widget/slippage_slider/slippage_slider.dart';
import 'widget/swap_widget.dart';

class SwapPage extends GetView<SwapController> {
  const SwapPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SwapController());
    return Obx(
      () {
        return Column(
          children: <Widget>[
            const SwapWidget(),
            if (controller.swapService.fetchingPrice.value)
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
