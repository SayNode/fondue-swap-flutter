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

BigInt multiplyBigintWithDouble(BigInt bigInt, double doubleValue) {
  // Split the double into its whole and fractional parts
  final int wholePart = doubleValue.truncate();
  final double fractionalPart = doubleValue - wholePart;

  // Multiply the BigInt by the whole part
  final BigInt wholeProduct = bigInt * BigInt.from(wholePart);

  // Multiply the BigInt by the fractional part
  final BigInt fractionalProduct =
      (bigInt * BigInt.from((fractionalPart * 1e10).round())) ~/
          BigInt.from(1e10);

  // Add the two products together
  return wholeProduct + fractionalProduct;
}
