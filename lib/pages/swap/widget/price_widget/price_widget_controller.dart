import 'package:get/get.dart';

import '../../../../services/swap_service.dart';

class PricerWidgetController extends GetxController {
  final SwapService swapService = Get.find<SwapService>();
  RxBool expanded = false.obs;
  RxBool showFetchingPrice = false.obs;
  @override
  void onInit() {
    swapService.fetchingPrice.listen((bool fetching) {
      if (fetching) {
        showFetchingPrice.value = true;
      } else {
        showFetchingPrice.value = false;
      }
    });
    super.onInit();
  }
}
