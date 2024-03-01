import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/pool.dart';
import '../../../services/new_position_service.dart';
import '../../../utils/pool_util.dart';
import '../../../utils/util.dart';
import '../../../widgets/loading_widget.dart';
import '../../../widgets/success_fail_popup.dart';
import '../../password_page/password_page.dart';

class NewPositionController extends GetxController {
  final NewPositionService newPositionService = Get.find<NewPositionService>();
  final TextEditingController tokenXAmountController = TextEditingController();
  final TextEditingController tokenYAmountController = TextEditingController();

  RxBool lockTokenXInput = false.obs;
  RxBool lockTokenYInput = false.obs;

  @override
  void onInit() {
    newPositionService.tokenX.listen((_) async {
      await updatePool();
    });
    newPositionService.tokenY.listen((_) async {
      await updatePool();
    });
    newPositionService.fee.listen((_) async {
      await updatePool();
    });

    newPositionService.maxPrice.listen((_) async {
      bool xToY = false;
      if (newPositionService.pool.value!.tokenX ==
          newPositionService.tokenX.value!.tokenAddress) {
        xToY = true;
      }
      if (newPositionService.maxPrice.value <
          sqrtPriceX96ToNormalPrice(newPositionService.pool.value!.price!)) {
        if (xToY) {
          lockTokenXInput.value = true;
        } else {
          lockTokenYInput.value = true;
        }
      } else {
        if (xToY) {
          lockTokenXInput.value = false;
        } else {
          lockTokenYInput.value = false;
        }
        lockTokenXInput.value = false;
      }
      tokenXAmountController.text = '';
      tokenYAmountController.text = '';
    });

    newPositionService.minPrice.listen((_) async {
      bool xToY = false;
      if (newPositionService.pool.value!.tokenX ==
          newPositionService.tokenX.value!.tokenAddress) {
        xToY = true;
      }
      if (newPositionService.minPrice.value >
          sqrtPriceX96ToNormalPrice(newPositionService.pool.value!.price!)) {
        if (xToY) {
          lockTokenXInput.value = true;
        } else {
          lockTokenYInput.value = true;
        }
      } else {
        if (xToY) {
          lockTokenXInput.value = false;
        } else {
          lockTokenYInput.value = false;
        }
      }

      tokenXAmountController.text = '';
      tokenYAmountController.text = '';
    });
    super.onInit();
  }

  Future<double> getTokenY() async {
    bool xToY = false;
    if (newPositionService.pool.value!.tokenX ==
        newPositionService.tokenX.value!.tokenAddress) {
      xToY = true;
    }
    final BigInt amountXBig =
        await newPositionService.calcTokenInputForLiquidity(
      lowerTick: getTick(newPositionService.minPrice.value),
      upperTick: getTick(newPositionService.maxPrice.value),
      amountIn: multiplyBigintWithDouble(
        BigInt.from(pow(10, 18)),
        double.parse(tokenXAmountController.text),
      ),
      xToY: xToY,
    );
    final double normalPrice = amountXBig / BigInt.from(pow(10, 18));
    return normalPrice;
  }

  Future<double> getTokenX() async {
    bool xToY = false;
    if (newPositionService.pool.value!.tokenX ==
        newPositionService.tokenX.value!.tokenAddress) {
      xToY = true;
    }
    final BigInt amountXBig =
        await newPositionService.calcTokenInputForLiquidity(
      lowerTick: getTick(newPositionService.minPrice.value),
      upperTick: getTick(newPositionService.maxPrice.value),
      amountIn: multiplyBigintWithDouble(
        BigInt.from(pow(10, 18)),
        double.parse(tokenYAmountController.text),
      ),
      xToY: !xToY,
    );
    final double normalPrice = amountXBig / BigInt.from(pow(10, 18));
    return normalPrice;
  }

  Future<void> createNewPosition() async {
    await Get.to<Widget>(
      () => PasswordPage(
        'Password required'.tr,
        'To proceed with the swap, please enter your password. Your password ensures transaction security.'
            .tr,
        'Confirm'.tr,
        submit: _createNewPosition,
      ),
    );
  }

  Future<void> _createNewPosition(String password) async {
    bool yTox = false;
    if (newPositionService.pool.value!.tokenX ==
        newPositionService.tokenX.value!.tokenAddress) {
      yTox = true;
    }

    final BigInt amount0Desired = multiplyBigintWithDouble(
      BigInt.from(pow(10, 18)),
      newPositionService.tokenXAmount.value,
    );
    final BigInt amount1Desired = multiplyBigintWithDouble(
      BigInt.from(pow(10, 18)),
      newPositionService.tokenYAmount.value,
    );
    final BigInt amount0Min = multiplyBigintWithDouble(
      BigInt.from(pow(10, 18)),
      double.parse(tokenXAmountController.text) *
          (1 - (newPositionService.slippage.value / 100)),
    );
    final BigInt amount1Min = multiplyBigintWithDouble(
      BigInt.from(pow(10, 18)),
      double.parse(tokenYAmountController.text) *
          (1 - (newPositionService.slippage.value / 100)),
    );
    unawaited(
      Get.dialog<Widget>(const LoadingWidget(), barrierDismissible: false),
    );

    print('amount0Desired: $amount0Desired');
    print('amount1Desired: $amount1Desired');

    try {
      await newPositionService.mintNewPosition(
        password: password,
        lowerTick: getTick(newPositionService.minPrice.value),
        upperTick: getTick(newPositionService.maxPrice.value),
        amount0Desired: !yTox ? amount1Desired : amount0Desired,
        amount1Desired: !yTox ? amount0Desired : amount1Desired,
        amount0Min: !yTox ? amount1Min : amount0Min,
        amount1Min: !yTox ? amount0Min : amount1Min,
      );
      Get.close(3);
      openPopup(
        success: true,
        title: 'Transaction Confirmed',
        content: 'Position created successfully',
      );
    } catch (e) {
      Get.close(2);
      openPopup(
        success: false,
        title: 'Pool Unsuccessful',
        content: 'Transaction failed: $e',
      );
    }
  }

  Future<void> updatePool() async {
    //If tokenX, tokenY and fee are selected, get the pool
    if (newPositionService.tokenX.value != null &&
        newPositionService.tokenY.value != null &&
        newPositionService.fee.value != 0.0) {
      newPositionService.fetchingPoolData.value = true;
      final List<Pool> poolListForTokenPair = await getCreatedPools(
        tokenX: newPositionService.tokenX.value!.tokenAddress,
        tokenY: newPositionService.tokenY.value!.tokenAddress,
      );

      if (poolListForTokenPair.isNotEmpty) {
        newPositionService.pool.value = (poolListForTokenPair
              ..where(
                (Pool pool) =>
                    pool.fee / BigInt.from(10000) ==
                    newPositionService.fee.value,
              ))
            .first;

        final String poolAddress =
            await getPoolAddress(pool: newPositionService.pool.value!);
        newPositionService.pool.value!.address = poolAddress;
        newPositionService.pool.value!.price =
            await getSqrtPriceX96(newPositionService.pool.value!.address!);
      } else {
        debugPrint('No pool found for the given token pair');
      }
    }
    newPositionService.fetchingPoolData.value = false;
  }
}
