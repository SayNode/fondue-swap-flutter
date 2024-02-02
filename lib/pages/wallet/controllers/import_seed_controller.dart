import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thor_devkit_dart/crypto/mnemonic.dart';

import '../../../services/wallet_service.dart';
import '../../password_page/password_page.dart';
import '../wallet_added_page.dart';
import '../widgets/loading_page.dart';

class ImportSeedController extends GetxController {
  RxBool buttonDisabled = true.obs;
  TextEditingController seedPhraseController = TextEditingController();
  RxBool invalidSeed = false.obs;
  WalletService walletService = Get.put(WalletService());

  /// Submit the seed phrase, if it is valid, encrypt it as keystore withg user password and save it to local storage
  void submit() {
    debugPrint('submit');
    if (Mnemonic.validate(seedPhraseController.text.toLowerCase().split(' '))) {
      invalidSeed.value = false;
      Get.to<Widget>(
        () => PasswordPage(
          submit: (String password) async {
            LoadingPage.show();
            // ignore: inference_failure_on_instance_creation, always_specify_types
            await Future.delayed(const Duration(seconds: 1));
            await walletService.importWalletWithSeed(
              password,
              seedPhraseController.text,
            );

            Get.close(2);
            await showDialog<Widget>(
              context: Get.context!,
              builder: (BuildContext context) {
                return const WalletAddedPage();
              },
            );
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

      final List<String> wordList = value.split(' ');
      if (wordList.length != 12 &&
          wordList.length != 18 &&
          wordList.length != 24) {
        buttonDisabled.value = true;
      }
    }
  }
}
