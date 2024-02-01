import 'package:get/get.dart';

import '../widget/select_token_bottom_sheet.dart';

class SwapWidgetController extends GetxController {
  Future<void> selectToken() async {
    await Get.bottomSheet<void>(
      const SelectTokenBottomSheet(),
      isDismissible: false,
    );
  }
}
