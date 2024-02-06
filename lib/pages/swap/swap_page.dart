import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/util.dart';
import '../../widgets/fondue_button.dart';
import 'controller/swap_controller.dart';
import 'widget/price_widget.dart';
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
            if (controller.showPriceWidget.value)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: PriceWidget(),
              ),
            const Spacer(),
            const FondueButton(text: 'Swap now'),
            SizedBox(height: getRelativeHeight(30)),
          ],
        );
      },
    );
  }
}
