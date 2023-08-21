import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImportPrivateKeyController extends GetxController {
  TextEditingController privateKeyController = TextEditingController();
  RxBool invalidPrivateKey = false.obs;
  RxBool buttonDisabled = true.obs;
  submit() {}
}
