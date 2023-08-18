import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../pages/signup_pages.dart/controller/signup_controller.dart';
import '../services/theme_service.dart';
import '../theme/constants.dart';

class FondueTextField extends StatelessWidget {
  const FondueTextField(
      {super.key,
      this.labelText,
      required this.controller,
      required this.onChanged});
  final String? labelText;
  final TextEditingController controller;
  final void Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    var signUpController = Get.put(SignUpController());
    final theme = Get.put(ThemeService()).fondueSwapTheme;
    return Obx(
      () => TextField(
        onChanged: onChanged,
        obscureText: signUpController.obscureText.value,
        controller: controller,
        style: FondueSwapConstants.fromColor(theme.mistyLavender).kRoboto16,
        decoration: InputDecoration(
          filled: true,
          fillColor: theme.graphite,
          labelText: labelText ?? '',
          labelStyle:
              FondueSwapConstants.fromColor(theme.mistyLavender).kRoboto16,
          suffixIcon: GestureDetector(
            onTap: () => signUpController.togglePasswordVisibility(),
            child: Icon(
              Icons.visibility,
              color: theme.mistyLavender,
            ),
          ),
        ),
      ),
    );
  }
}
