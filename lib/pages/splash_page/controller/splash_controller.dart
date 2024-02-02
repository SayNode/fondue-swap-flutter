import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../home/controllers/home_controller.dart';
import '../../../services/wallet_service.dart';
import 'package:get/get.dart';

import '../../../utils/globals.dart';

class SplashPageController extends GetxController {
  bool hasAccount = false;
  @override
  void onInit() {
    Get.lazyPut(HomeController.new);

    super.onInit();
  }

  Future<bool> initAsyncServices() async {
    await Get.put(WalletService()).init();

//check if user has an account
    const FlutterSecureStorage storage = FlutterSecureStorage();
    final String? storedHashedPassword =
        await storage.read(key: encryptedMessage);
    if (storedHashedPassword != null) {
      hasAccount = true;
    }
    return true;
  }
}
