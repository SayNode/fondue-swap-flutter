import 'package:flutter/material.dart';
import 'package:get/get.dart';

double getRelativeWidth(double width) {
  final Size screenSize = MediaQuery.of(Get.context!).size;
  return screenSize.width * (width / 360);
}

double getRelativeHeight(double height) {
  final Size screenSize = MediaQuery.of(Get.context!).size;
  return screenSize.height * (height / 800);
}
