import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import '../../../services/swap_service.dart';
import '../../../services/token_service.dart';
import '../../../services/wallet_service.dart';
import '../../../utils/globals.dart';
import '../../home/controllers/home_controller.dart';

class SplashPageController extends GetxController {
  bool hasAccount = false;
  @override
  void onInit() {
    Get
      ..lazyPut(HomeController.new)
      ..lazyPut(SwapService.new);
    super.onInit();
  }

  Future<bool> initAsyncServices() async {
    await Get.put(WalletService()).init();
    await Get.put(TokenService()).init();

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
