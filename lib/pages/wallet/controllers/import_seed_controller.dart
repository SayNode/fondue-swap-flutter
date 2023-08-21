import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thor_devkit_dart/crypto/mnemonic.dart';

class ImportSeedController extends GetxController {
  RxBool buttonDisabled = true.obs;
  TextEditingController seedPhraseController = TextEditingController();
  RxBool invalidSeed = false.obs;

  /// Submit the seed phrase, if it is valid, encrypt it as keystore withg user password and save it to local storage
  void submit() {
    debugPrint('submit');
    if (Mnemonic.validate(seedPhraseController.text.toLowerCase().split(' '))) {
      invalidSeed.value = false;
      //
      //
      //
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
