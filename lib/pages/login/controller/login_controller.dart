import 'package:crypt/crypt.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fondue_swap/utils/globals.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  TextEditingController passwordController = TextEditingController();

  RxBool validPassword = true.obs;

  submit() async {
    bool isPasswordValid = await checkPassword();

    if (isPasswordValid) {
      debugPrint("Welcome");

      validPassword.value = true;
      passwordController.text = '';
      debugPrint("correct password");
    } else {
      validPassword.value = false;

      debugPrint("Wrong password");
    }
  }

  Future<bool> checkPassword() async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    String? storedHashedPassword = await storage.read(key: encryptedMessage);
    if (storedHashedPassword == null) {
      return Future.value(false);
    }
    return Future.value(Crypt(storedHashedPassword).match(passwordController.text));
  }
}
