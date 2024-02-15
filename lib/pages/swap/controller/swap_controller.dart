import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/token.dart';
import '../../../services/swap_service/swap_service.dart';
import '../widget/select_token_bottom_sheet.dart';

class SwapController extends GetxController {
  final SwapService swapService = Get.find<SwapService>();
  TextEditingController tokenInController = TextEditingController();
  TextEditingController tokenOutController = TextEditingController();
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
    }
  }

  Future<void> swap() async {
    final Token? tokenX = swapService.tokenX.value;
    final Token? tokenY = swapService.tokenY.value;
    if (tokenX != null && tokenY != null) {
      swapService.tokenX.value = tokenY;
      swapService.tokenY.value = tokenX;
    }
    await swapService.fetchBestPrice();
  }
}
