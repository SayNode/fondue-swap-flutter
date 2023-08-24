import 'package:flutter/material.dart';
import 'package:fondue_swap/pages/wallet/wallet_added_page.dart';
import 'package:fondue_swap/services/wallet_service.dart';
import 'package:get/get.dart';

import '../../password_page/password_page.dart';
import '../widgets/loading_page.dart';

class ImportPrivateKeyController extends GetxController {
  TextEditingController privateKeyController = TextEditingController();
  RxBool invalidPrivateKey = false.obs;
  RxBool buttonDisabled = true.obs;
  var walletService = Get.put(WalletService());

  onChangedPrivateKeyTextField() {
    if (privateKeyController.text.isEmpty) {
      buttonDisabled.value = true;
    } else {
      buttonDisabled.value = false;
    }
  }

  void submit() {
    Get.to(
      () => PasswordPage(
        submit: (password) async {
          invalidPrivateKey.value = false;
          Get.close(1);
          LoadingPage.show();
          bool success = await walletService.importWalletWithPrivateKey(
              password, privateKeyController.text);
          if (success) {
            Get.close(1);
            showDialog(
                context: Get.context!,
                builder: (BuildContext context) {
                  return const WalletAddedPage();
                });
          } else {
            invalidPrivateKey.value = true;
            Get.close(1);
          }
        },
      ),
    );
  }
}
