import 'package:get/get.dart';

import '../../../../../models/token.dart';
import '../../../../../services/new_position_service.dart';
import '../../../../../widgets/select_token_bottom_sheet.dart';

class SelectTokenController extends GetxController {
  final NewPositionService newPositionService = Get.find<NewPositionService>();

  Future<void> selectTokenX() async {
    await Get.bottomSheet<void>(
      SelectTokenBottomSheet(
        onTokenPressed: (Token token) {
          newPositionService.tokenX.value = token;
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
          newPositionService.tokenY.value = token;
          Get.back<void>();
        },
      ),
      isDismissible: false,
    );
  }
}
