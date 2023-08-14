import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Password {
  int strength = 1;
  RxString text = 'weak'.obs;
  Color color = Colors.red;
  Password();
  update(int strength) {
    if (this.strength != strength) {
      switch (strength) {
        case 1:
          text.value = 'weak';
          color = Colors.red;
          this.strength = strength;
          break;
        case 2:
          text.value = 'average';
          color = Colors.orange;
          this.strength = strength;
          break;
        case 3:
          text.value = 'strong';
          color = Colors.lightGreen;
          this.strength = strength;
          break;
        case 4:
          text.value = 'very strong';
          color = Colors.green;
          this.strength = strength;
          break;
        default:
          text.value = 'weak';
          color = Colors.red;
          this.strength = strength;
          break;
      }
    }
  }
}

int determinePasswordStrength(String password) {
  int strength = 0;

  strength += password.contains(RegExp(r'[A-Z]')) ? 1 : 0;
  strength += password.contains(RegExp(r'[0-9]')) ? 1 : 0;
  strength += password.contains(RegExp(r'[a-z]')) ? 1 : 0;
  strength += password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]')) ? 1 : 0;
  strength += password.length >= 8 ? 10 : 0;
  if (strength < 12) {
    return 1;
  }
  if (strength == 12) {
    return 2;
  }
  if (strength == 13) {
    return 3;
  }
  if (strength > 13) {
    return 4;
  } else {
    return 1;
  }
}

// bool verifyPasswordRequirements(String password) {
//   // check if has one upper case letter, one lower case letter, one number, no spaces and at least 8 characters
//   return RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?!.*\s).{8,}$').hasMatch(password);
// }
