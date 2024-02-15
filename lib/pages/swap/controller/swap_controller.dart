import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/token.dart';
import '../../../services/swap_service/swap_service.dart';
import '../../../widgets/loading_widget.dart';
import '../../password_page/password_page.dart';
import '../widget/select_token_bottom_sheet.dart';

class SwapController extends GetxController {
  final SwapService swapService = Get.find<SwapService>();
  TextEditingController tokenInController = TextEditingController();
  TextEditingController tokenOutController = TextEditingController();
  RxBool gotQuote = false.obs;
  String prev = '';

  @override
  void onInit() {
    super.onInit();
    tokenInController.addListener(_listener);
    swapService.tokenX.listen((_) async {
      print('tokenX changed');
      await fetchBestPrice();
    });
    swapService.tokenY.listen((_) async {
      print('tokenY changed');
      await fetchBestPrice();
    });
    swapService.slippage.listen((_) async {
      print('slippage changed');
      await fetchBestPrice();
    });
  }

  Future<void> _listener() async {
    if (prev != tokenInController.text) {
      prev = tokenInController.text;
      swapService.amountX.value = BigInt.from(
        (double.parse(tokenInController.text) * 1000000000000000000).floor(),
      );
      await fetchBestPrice();
    }
  }

  Future<void> selectTokenX() async {
    await Get.bottomSheet<void>(
      SelectTokenBottomSheet(
        onTokenPressed: (Token token) {
          swapService.tokenX.value = token;
          Get.back<void>();
        },
      ),
      isDismissible: false,
    );
  }

  Future<void> selectTokenY() async {
    await Get.bottomSheet<void>(
      SelectTokenBottomSheet(
        onTokenPressed: (Token token) {
          swapService.tokenY.value = token;
          Get.back<void>();
        },
      ),
      isDismissible: false,
    );
  }

  Future<void> fetchBestPrice() async {
    gotQuote.value = false;
    tokenOutController.text = '';
    if (swapService.tokenX.value != null &&
        swapService.tokenY.value != null &&
        swapService.slippage.value != 0 &&
        swapService.amountX.value != BigInt.zero) {
      swapService.fetchingPrice.value = true;
      final BigInt quote = await swapService.fetchBestPrice();
      tokenOutController.text = (quote / BigInt.from(1000000000000000000))
          .toStringAsFixed(6)
          .replaceAll(RegExp(r'([.]*0)(?!.*\d)'), '');
      swapService.fetchingPrice.value = false;
      gotQuote.value = true;
    }
  }

  Future<void> swap() async {
    await Get.to<Widget>(
      () => PasswordPage(
        'Password required'.tr,
        'To proceed with the swap, please enter your password. Your password ensures transaction security.'
            .tr,
        'Confirm'.tr,
        submit: _swap,
      ),
    );
  }

  Future<void> _swap(String password) async {
    unawaited(Get.dialog<Widget>(const LoadingWidget()));
    final String txId = await swapService.swap(
      tokenXAddress: swapService.tokenX.value!.tokenAddress,
      tokenYAddress: swapService.tokenY.value!.tokenAddress,
      amountX: swapService.amountX.value,
      poolFee: swapService.poolFee,
      maxPriceVariation: swapService.maxPriceVariation,
      password: password,
    );
    print('txId: $txId');
    swapService.reset();
    Get.close(2);
  }
}
