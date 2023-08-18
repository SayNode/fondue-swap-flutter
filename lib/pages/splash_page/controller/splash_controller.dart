import 'package:fondue_swap/pages/home/controllers/home_controller.dart';
import 'package:get/get.dart';

class SplashPageController extends GetxController {
  @override
  void onInit() {
    Get.lazyPut(() => HomeController());
    super.onInit();
  }
}
