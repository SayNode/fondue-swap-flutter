import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../../../../models/token.dart';
import '../../../../../services/new_position_service.dart';
import '../../../../../services/theme_service.dart';
import '../../../../../theme/custom_theme.dart';
import '../../../../../utils/pool_util.dart';

class PriceRangeSelectorController extends GetxController {
  final FondueSwapTheme theme = Get.put(ThemeService()).fondueSwapTheme;
  final NewPositionService newPositionService = Get.find<NewPositionService>();
  final TextEditingController tokenXAmountController = TextEditingController();
  final TextEditingController tokenYAmountController = TextEditingController();
  final TextEditingController minPriceController = TextEditingController();
  final TextEditingController maxPriceController = TextEditingController();
  RxDouble sliderMax = 0.0.obs;
  RxDouble sliderMin = 0.0.obs;
  Rx<SfRangeValues> rangeValues = const SfRangeValues(4, 8).obs;

  @override
  void onInit() {
    newPositionService.maxPrice.listen((double? value) {
      if (value != null && value != rangeValues.value.end) {
        rangeValues.value = SfRangeValues(
          rangeValues.value.start,
          value,
        );
      }
    });
    newPositionService.minPrice.listen((double? value) {
      if (value != null && value != rangeValues.value.start) {
        rangeValues.value = SfRangeValues(
          value,
          rangeValues.value.end,
        );
      }
    });
    newPositionService.canSelectPRiceRange.listen((bool value) {
      if (value) {
        newPositionService.fetchingPoolData.listen((bool value) {
          if (!value) {
            final double normalPrice = sqrtPriceX96ToNormalPrice(
              newPositionService.pool.value!.price!,
            );
            rangeValues.value = SfRangeValues(
              normalPrice,
              normalPrice,
            );
            sliderMax.value =
                (normalPrice + normalPrice / 10).floor().toDouble();
            sliderMin.value =
                (normalPrice - normalPrice / 10).floor().toDouble();
          }
        });
      }
    });

    newPositionService.tokenX.listen((Token? token) {
      newPositionService.canSelectPRiceRange.value =
          newPositionService.checkIfPoolSelected();
    });
    newPositionService.tokenY.listen((Token? token) {
      newPositionService.canSelectPRiceRange.value =
          newPositionService.checkIfPoolSelected();
    });
    newPositionService.fee.listen((double? fee) {
      newPositionService.canSelectPRiceRange.value =
          newPositionService.checkIfPoolSelected();
    });
    super.onInit();
  }

  void decreaseMinPrice() {
    final double normalPrice = sqrtPriceX96ToNormalPrice(
      newPositionService.pool.value!.price!,
    );
    double oldValue = 0;
    double newValue = 0;
    if (minPriceController.text.isNotEmpty) {
      oldValue = double.parse(minPriceController.text);
    }
    newValue = oldValue - (normalPrice * 0.01);
    if (newValue < 0.0) {
      newValue = 0.0;
    }
    minPriceController.text = newValue.toString();

    newPositionService.minPrice.value = double.parse(minPriceController.text);
  }

  void increaseMinPrice() {
    final double normalPrice = sqrtPriceX96ToNormalPrice(
      newPositionService.pool.value!.price!,
    );
    double oldValue = 0;
    double newValue = 0;
    if (minPriceController.text.isNotEmpty) {
      oldValue = double.parse(minPriceController.text);
    }
    newValue = oldValue + (normalPrice * 0.01);
    minPriceController.text = newValue.toString();

    newPositionService.minPrice.value = double.parse(minPriceController.text);
  }

  void decreaseMaxPrice() {
    final double normalPrice = sqrtPriceX96ToNormalPrice(
      newPositionService.pool.value!.price!,
    );
    double oldValue = 0;
    double newValue = 0;
    if (maxPriceController.text.isNotEmpty) {
      oldValue = double.parse(maxPriceController.text);
    }
    newValue = oldValue - (normalPrice * 0.01);
    if (newValue < 0.0) {
      newValue = 0.0;
    }
    maxPriceController.text = newValue.toString();

    newPositionService.maxPrice.value = double.parse(maxPriceController.text);
  }

  void increaseMaxPrice() {
    final double normalPrice = sqrtPriceX96ToNormalPrice(
      newPositionService.pool.value!.price!,
    );
    double oldValue = 0;
    double newValue = 0;
    if (maxPriceController.text.isNotEmpty) {
      oldValue = double.parse(maxPriceController.text);
    }
    newValue = oldValue + (normalPrice * 0.01);
    maxPriceController.text = newValue.toString();

    newPositionService.maxPrice.value = double.parse(maxPriceController.text);
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
