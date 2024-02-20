import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../services/new_position_service.dart';
import '../../../../../utils/util.dart';

class SlippageSliderNewPositionController extends GetxController {
  final RxDouble offset = 0.0.obs;
  double temp = 0;
  int slippage = 0;
  final NewPositionService swapService = Get.find<NewPositionService>();
  final double x = getRelativeWidth(237) / 25;

  void onDragEnd(DragEndDetails details) {
    temp = offset.value;
    swapService.slippage.value = slippage;
  }

  void onDragUpdate(DragUpdateDetails details) {
    //print(details.localPosition.dx);
    if (details.localPosition.dx + temp > 0 &&
        details.localPosition.dx + temp < getRelativeWidth(237)) {
      offset.value = details.localPosition.dx + temp;
    }
    slippage = (offset.value / x).round();
  }
}
