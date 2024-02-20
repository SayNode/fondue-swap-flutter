import 'package:get/get.dart';

import '../../../services/position_service.dart';

class PotsPageController extends GetxController {
  final PositionService positionService = Get.put(PositionService());

  @override
  Future<void> onInit() async {
    positionService.positionList.value = await positionService.fetchPositions();
    super.onInit();
  }
}
