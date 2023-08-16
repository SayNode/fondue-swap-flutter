import 'package:get/get.dart';

class SignUpController extends GetxController {
  RxBool obscureText = true.obs;

  void visiblePassword() {
    obscureText.value = !obscureText.value;
  }
}
