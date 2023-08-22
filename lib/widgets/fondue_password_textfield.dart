import 'package:flutter/material.dart';
import 'package:fondue_swap/theme/colors.dart';
import 'package:get/get.dart';

import '../pages/signup_pages.dart/controller/signup_controller.dart';
import '../services/theme_service.dart';
import '../theme/constants.dart';

class FonduePasswordTextField extends StatelessWidget {
  const FonduePasswordTextField({super.key, this.labelText, required this.controller, this.onChanged});
  final String? labelText;
  final TextEditingController controller;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    var signUpController = Get.put(SignUpController());
    final theme = Get.put(ThemeService()).fondueSwapTheme;
    return Obx(
      () => TextField(
        focusNode: signUpController.textFieldNode,
        onChanged: onChanged,
        obscureText: signUpController.obscureText.value,
        controller: controller,
        style: FondueSwapConstants.fromColor(theme.mistyLavender).kRoboto16,
        decoration: InputDecoration(
          filled: true,
          fillColor: theme.graphite,
          labelText: labelText ?? '',
          labelStyle: FondueSwapConstants.fromColor(theme.mistyLavender).kRoboto16,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(10.0), // Adjust the radius as needed
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: FondueSwapColor.goldenSunset),
            borderRadius: BorderRadius.circular(10.0), // Adjust the radius as needed
          ),
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
