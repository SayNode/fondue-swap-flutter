import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../services/swap_service/swap_service.dart';
import '../../../../utils/util.dart';

class SlippageSliderController extends GetxController {
  final RxDouble offset = 0.0.obs;
  double temp = 0;
  final SwapService swapService = Get.find<SwapService>();
  final double x = getRelativeWidth(237) / 25;

  void onDragEnd() {
    temp = offset.value;
  }

  void onDragUpdate(DragUpdateDetails details) {
    //print(details.localPosition.dx);
    if (details.localPosition.dx + temp > 0 &&
        details.localPosition.dx + temp < getRelativeWidth(237)) {
      offset.value = details.localPosition.dx + temp;
    }
    swapService.slippage.value = (offset.value / x).round();
  }
}
