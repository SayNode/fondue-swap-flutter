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
  final List<int> bigIntArray =
      bigInt.toString().split('').map(int.parse).toList();

  final List<int> reminder = <int>[];

  final List<int> result = <int>[];

  for (int i = 0; i < bigIntArray.length; i++) {
    final int numberToAdd = (reminder.isNotEmpty) ? reminder.removeAt(0) : 0;
    final double temp = (bigIntArray[i] * doubleValue) + numberToAdd;

    if (temp > 10) {
      result.add((temp - 10).floor());
      if (i == 0) {
        result.insert(0, 1);
      } else {
        result[i - 1] = result[i - 1] + 1;
      }
    } else {
      result.add(temp.floor());
    }

    final double tempReminder = temp % 10;
    final String s = tempReminder.toString();
    final String substring = s.substring(s.indexOf('.')).substring(1);
    if (int.parse(substring) > 0) {
      final List<String> characterListAll = substring.split('');
      final List<String> characterListNewEntries =
          characterListAll.sublist(reminder.length);
      final List<String> characterListToAdd =
          characterListAll.sublist(0, reminder.length);

      for (int i = 0; i < characterListToAdd.length; i++) {
        reminder[i] += int.parse(characterListToAdd[i]);
      }
      for (int i = 0; i < characterListNewEntries.length; i++) {
        reminder.add(int.parse(characterListNewEntries[i]));
      }
    }
  }
  return BigInt.parse(result.join());
}
