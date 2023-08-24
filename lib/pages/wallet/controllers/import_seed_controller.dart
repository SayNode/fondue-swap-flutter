import 'package:flutter/material.dart';
import 'package:fondue_swap/services/wallet_service.dart';
import 'package:get/get.dart';
import 'package:thor_devkit_dart/crypto/mnemonic.dart';

import '../../password_page/password_page.dart';
import '../wallet_added_page.dart';
import '../widgets/loading_page.dart';

class ImportSeedController extends GetxController {
  RxBool buttonDisabled = true.obs;
  TextEditingController seedPhraseController = TextEditingController();
  RxBool invalidSeed = false.obs;
  var walletService = Get.put(WalletService());

  /// Submit the seed phrase, if it is valid, encrypt it as keystore withg user password and save it to local storage
  void submit() {
    debugPrint('submit');
    if (Mnemonic.validate(seedPhraseController.text.toLowerCase().split(' '))) {
      invalidSeed.value = false;
      Get.to(
        () => PasswordPage(
          submit: (password) async {
            LoadingPage.show();
            await Future.delayed(const Duration(seconds: 1));
            await walletService.importWalletWithSeed(
                password, seedPhraseController.text);

            Get.close(2);
            showDialog(
                context: Get.context!,
                builder: (BuildContext context) {
                  return const WalletAddedPage();
                });
          },
        ),
      );
    } else {
      invalidSeed.value = true;
    }
  }

  void onChangedSeedPhraseTextField(String value) {
    if (value.isEmpty) {
      buttonDisabled.value = true;
    } else {
      buttonDisabled.value = false;

      var wordList = value.split(' ');
      if (wordList.length != 12 &&
          wordList.length != 18 &&
          wordList.length != 24) {
        buttonDisabled.value = true;
      }
    }
  }
}
