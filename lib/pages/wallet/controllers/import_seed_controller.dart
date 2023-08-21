import 'package:flutter/material.dart';
import 'package:fondue_swap/pages/home/home_page_loader.dart';
import 'package:fondue_swap/services/wallet_service.dart';
import 'package:get/get.dart';
import 'package:thor_devkit_dart/crypto/mnemonic.dart';

import '../../password_page/password_page.dart';

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
            //TODO: show loading screen
            await walletService.importWalletWithSeed(password, seedPhraseController.text);
            Get.to(() => const HomePageLoader());
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
      if (wordList.length != 12 && wordList.length != 18 && wordList.length != 24) {
        buttonDisabled.value = true;
      }
    }
  }
}
