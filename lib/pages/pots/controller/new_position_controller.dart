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

  @override
  void onInit() {
    newPositionService.tokenX.listen((_) async {
      print('tokenX: ${newPositionService.tokenX.value}');
      await updatePool();
    });
    newPositionService.tokenY.listen((_) async {
      print('tokenY: ${newPositionService.tokenY.value}');
      await updatePool();
    });
    newPositionService.fee.listen((_) async {
      print('fee: ${newPositionService.fee.value}');
      await updatePool();
    });
    super.onInit();
  }

  Future<String> getTokenY() async {
    final BigInt amountXBig =
        await newPositionService.calcTokenInputForLiquidity(
      lowerTick: getTick(newPositionService.minPrice.value),
      upperTick: getTick(newPositionService.maxPrice.value),
      amountIn: multiplyBigintWithDouble(
        BigInt.from(pow(10, 18)),
        double.parse(tokenXAmountController.text),
      ),
    );
    final double normalPrice = amountXBig / BigInt.from(pow(10, 18));
    return normalPrice.toString();
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
    print('Creating new position');
    final BigInt amount0Desired = multiplyBigintWithDouble(
      BigInt.from(pow(10, 18)),
      double.parse(tokenXAmountController.text),
    );
    final BigInt amount1Desired = multiplyBigintWithDouble(
      BigInt.from(pow(10, 18)),
      double.parse(tokenYAmountController.text),
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
    print('Minting new position');
    print('amount0Desired: $amount0Desired');
    print('amount1Desired: $amount1Desired');
    print('amount0Min: $amount0Min');
    print('amount1Min: $amount1Min');
    print('lowerTick: ${getTick(newPositionService.minPrice.value)}');
    print('upperTick: ${getTick(newPositionService.maxPrice.value)}');
    try {
      await newPositionService.mintNewPosition(
        password: password,
        lowerTick: getTick(newPositionService.minPrice.value),
        upperTick: getTick(newPositionService.maxPrice.value),
        amount0Desired: amount0Desired,
        amount1Desired: amount1Desired,
        amount0Min: amount0Min,
        amount1Min: amount1Min,
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
      print('Fetching pool data');
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

        print('Pool found for the given token pair');
        final String poolAddress =
            await getPoolAddress(pool: newPositionService.pool.value!);
        newPositionService.pool.value!.address = poolAddress;
        newPositionService.pool.value!.price =
            await getSqrtPriceX96(newPositionService.pool.value!.address!);
        print('Price: ${newPositionService.pool.value!.price}');
      } else {
        print('No pool found for the given token pair');
      }
    }
    newPositionService.fetchingPoolData.value = false;
  }
}
