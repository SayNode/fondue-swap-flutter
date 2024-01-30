import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'password_criteria.dart';

class PasswordStrength {
  PasswordStrength();
  int strength = 1;
  RxString text = 'weak'.obs;
  Rx<Color> color = Colors.red.obs;

  RxList<PasswordCriteria> criteria = <PasswordCriteria>[
    PasswordCriteria(
      'one lowercase character',
      1,
      (String password) => password.contains(RegExp('[a-z]')),
      validated: false,
    ),
    PasswordCriteria(
      'one uppercase character',
      1,
      (String password) => password.contains(RegExp('[A-Z]')),
      validated: false,
    ),
    PasswordCriteria(
      'one number',
      1,
      (String password) => password.contains(RegExp('[0-9]')),
      validated: false,
    ),
    PasswordCriteria(
      'one special character',
      1,
      (String password) => password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]')),
      validated: false,
    ),
    PasswordCriteria(
      '8 characters minimum',
      1,
      (String password) => password.length >= 8,
      validated: false,
    ),
  ].obs;

  void _updateUIParameters(int strength) {
    criteria.refresh();
    if (this.strength != strength) {
      switch (strength) {
        case 1:
          text.value = 'weak';
          color.value = Colors.red;
          this.strength = strength;
        case 2:
          text.value = 'average';
          color.value = Colors.orange;
          this.strength = strength;
        case 3:
          text.value = 'strong';
          color.value = Colors.lightGreen;
          this.strength = strength;
        case 4:
          text.value = 'very strong';
          color.value = Colors.green;
          this.strength = strength;
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
    for (final PasswordCriteria c in criteria) {
      strength += c.validate(password);
    }
    _updateUIParameters(strength);
    return strength;
  }
}
