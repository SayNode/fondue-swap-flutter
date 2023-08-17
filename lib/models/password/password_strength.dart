import 'package:flutter/material.dart';
import 'package:fondue_swap/models/password/password_criteria.dart';
import 'package:get/get.dart';

class PasswordStrength {
  int strength = 1;
  RxString text = 'weak'.obs;
  Rx<Color> color = Colors.red.obs;

  RxList<PasswordCriteria> criteria = <PasswordCriteria>[
    PasswordCriteria(
      "one lowercase character",
      1,
      (password) => password.contains(RegExp(r'[a-z]')),
      false,
    ),
    PasswordCriteria(
      "one uppercase character",
      1,
      (password) => password.contains(RegExp(r'[A-Z]')),
      false,
    ),
    PasswordCriteria(
      "one number",
      1,
      (password) => password.contains(RegExp(r'[0-9]')),
      false,
    ),
    PasswordCriteria(
      "one special character",
      1,
      (password) => password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]')),
      false,
    ),
    PasswordCriteria(
      "8 characters minimum",
      1,
      (password) => password.length >= 8,
      false,
    ),
  ].obs;

  PasswordStrength();

  void _updateUIParameters(int strength) {
    criteria.refresh();
    if (this.strength != strength) {
      switch (strength) {
        case 1:
          text.value = 'weak';
          color.value = Colors.red;
          this.strength = strength;
          break;
        case 2:
          text.value = 'average';
          color.value = Colors.orange;
          this.strength = strength;
          break;
        case 3:
          text.value = 'strong';
          color.value = Colors.lightGreen;
          this.strength = strength;
          break;
        case 4:
          text.value = 'very strong';
          color.value = Colors.green;
          this.strength = strength;
          break;
        default:
          text.value = 'weak';
          color.value = Colors.red;
          this.strength = strength;
          break;
      }
    }
  }

  int update(String password) {
    strength = 0;
    for (PasswordCriteria c in criteria) {
      strength += c.validate(password);
    }
    _updateUIParameters(strength);
    return strength;
  }
}
