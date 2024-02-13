import 'package:get/get.dart';

import '../../../models/token.dart';
import '../../../services/swap_service/swap_service.dart';
import '../widget/select_token_bottom_sheet.dart';

class SwapController extends GetxController {
  final SwapService swapService = Get.find<SwapService>();
  RxBool showPriceWidget = false.obs;

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

    if (swapService.tokenX.value != null && swapService.tokenY.value != null) {
      await getPrice();
    }
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

    if (swapService.tokenX.value != null && swapService.tokenY.value != null) {
      await getPrice();
    }
  }

  Future<void> getPrice() async {
    if (swapService.tokenX.value != null &&
        swapService.tokenY.value != null &&
        swapService.slippage.value != 0) {
      showPriceWidget.value = true;
    }
  }

  void swap() {
    final Token? tokenX = swapService.tokenX.value;
    final Token? tokenY = swapService.tokenY.value;
    if (tokenX != null && tokenY != null) {
      swapService.tokenX.value = tokenY;
      swapService.tokenY.value = tokenX;
    }
  }
}
