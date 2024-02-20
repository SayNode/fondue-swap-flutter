import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../services/new_position_service.dart';
import '../fee_box.dart';

class FeeSelectionController extends GetxController {
  RxBool expanded = false.obs;
  final NewPositionService newPositionService = Get.find<NewPositionService>();

  RxDouble get fee => newPositionService.fee;

  List<Widget> buildFeeBoxes() {
    final List<Widget> feeBoxes = <Widget>[
      const FeeBox(
        fee: 0.05,
        description: 'Best for stable pairs',
      ),
      const FeeBox(
        fee: 0.3,
        description: 'Best for  most pairs',
      ),
      const FeeBox(
        fee: 1,
        description: 'Best for  exotix pairs',
      ),
    ];
    return feeBoxes;
  }
}
