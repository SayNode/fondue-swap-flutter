import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../services/wallet_service.dart';
import '../../password_page/password_page_old.dart';
import '../wallet_added_page.dart';
import '../widgets/loading_page.dart';

class ImportPrivateKeyController extends GetxController {
  TextEditingController privateKeyController = TextEditingController();
  RxBool invalidPrivateKey = false.obs;
  RxBool buttonDisabled = true.obs;
  WalletService walletService = Get.put(WalletService());

  void onChangedPrivateKeyTextField() {
    if (privateKeyController.text.isEmpty) {
      buttonDisabled.value = true;
    } else {
      buttonDisabled.value = false;
    }
  }

  void submit() {
    Get.to<Widget>(
      () => PasswordPageOld(
        submit: (String password) async {
          invalidPrivateKey.value = false;
          Get.close(1);
          LoadingPage.show();
          final bool success = await walletService.importWalletWithPrivateKey(
            password,
            privateKeyController.text,
          );
          if (success) {
            Get.close(1);
            await showDialog<Widget>(
              context: Get.context!,
              builder: (BuildContext context) {
                return const WalletAddedPage();
              },
            );
          } else {
            invalidPrivateKey.value = true;
            Get.close(1);
          }
        },
      ),
    );
  }
}
