import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../services/theme_service.dart';
import '../../../theme/constants.dart';
import '../theme/custom_theme.dart';

class FondueTextField extends StatelessWidget {
  const FondueTextField({
    super.key,
    this.controller,
    this.onChanged,
    this.onSubmitted,
    this.hintText,
    this.passwordTextField = false,
    this.suffixIcon,
  });
  final TextEditingController? controller;
  final String? hintText;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final bool passwordTextField;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    final FondueSwapTheme theme = Get.put(ThemeService()).fondueSwapTheme;
    final RxBool obscureText = false.obs;
    if (passwordTextField) {
      obscureText.value = true;
    }
    return Obx(() {
      return TextField(
        obscureText: obscureText.value,
        onSubmitted: onSubmitted,
        textInputAction: TextInputAction.done,
        onChanged: onChanged,
        controller: controller,
        style: FondueSwapConstants.fromColor(theme.mistyLavender).kRoboto16,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide(color: theme.goldenSunset),
          ),
          filled: true,
          fillColor: theme.graphite,
          hintText: hintText,
          hintStyle:
              FondueSwapConstants.fromColor(theme.mistyLavender).kRoboto16,
          suffixIcon: passwordTextField
              ? GestureDetector(
                  onTap: obscureText.toggle,
                  child: (obscureText.value)
                      ? Icon(
                          Icons.visibility_off,
                          color: theme.mistyLavender,
                        )
                      : Icon(
                          Icons.visibility,
                          color: theme.mistyLavender,
                        ),
                )
              : suffixIcon,
        ),
      );
    });
  }
}
