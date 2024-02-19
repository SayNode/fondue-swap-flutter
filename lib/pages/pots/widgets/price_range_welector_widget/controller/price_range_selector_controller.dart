import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../../../../models/token.dart';
import '../../../../../services/new_position_service.dart';
import '../../../../../services/theme_service.dart';
import '../../../../../theme/custom_theme.dart';
import '../../../../../utils/pool_util.dart';

class PriceRangeSelectorController extends GetxController {
  RxBool canSelectPRiceRange = false.obs;
  final FondueSwapTheme theme = Get.put(ThemeService()).fondueSwapTheme;
  final NewPositionService newPositionService = Get.find<NewPositionService>();
  final TextEditingController tokenXAmountController = TextEditingController();
  final TextEditingController tokenYAmountController = TextEditingController();
  final TextEditingController minPriceController = TextEditingController();
  final TextEditingController maxPriceController = TextEditingController();
  Rx<SfRangeValues> rangeValues = const SfRangeValues(4, 8).obs;

  @override
  void onInit() {
    rangeValues.value = const SfRangeValues(4, 8);
    newPositionService.tokenX.listen((Token? token) {
      canSelectPRiceRange.value = newPositionService.checkIfPoolSelected();
    });
    newPositionService.tokenY.listen((Token? token) {
      canSelectPRiceRange.value = newPositionService.checkIfPoolSelected();
    });
    newPositionService.fee.listen((double? fee) {
      canSelectPRiceRange.value = newPositionService.checkIfPoolSelected();
      print('canSelectPRiceRange: $canSelectPRiceRange');
    });
    super.onInit();
  }

  String getPriceText() {
    if (newPositionService.pool.value != null) {
      final double normalPrice =
          sqrtPriceX96ToNormalPrice(newPositionService.pool.value!.price!);
      return '${normalPrice.toStringAsFixed(2)} ${newPositionService.tokenY.value!.abbreviation} per ${newPositionService.tokenX.value!.abbreviation}';
    }
    return '0';
  }

  void updatePriceRangeFromChart(SfRangeValues values) {
    minPriceController.text = values.start.toString();

    // ignore: avoid_dynamic_calls
    if (values.start.runtimeType == int) {
      // ignore: avoid_dynamic_calls
      newPositionService.minPrice.value = values.start.toDouble();
    } else {
      newPositionService.minPrice.value = values.start;
    }

    maxPriceController.text = values.end.toString();

    // ignore: avoid_dynamic_calls
    if (values.end.runtimeType == int) {
      // ignore: avoid_dynamic_calls
      newPositionService.maxPrice.value = values.end.toDouble();
    } else {
      newPositionService.maxPrice.value = values.end;
    }
  }

//Step size determined by fee of the given pool
  double getStepSize() {
    switch (newPositionService.fee.value) {
      case 0.05:
        return 0.001;
      case 0.3:
        return 0.006;
      case 1.0:
        return 0.02;
      default:
        return 0.1;
    }
  }
}
