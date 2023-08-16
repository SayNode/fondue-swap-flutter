import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../services/theme_service.dart';
import '../../theme/constants.dart';
import '../signup_pages.dart/controller/signup_controller.dart';

class FondueTextField extends StatelessWidget {
  FondueTextField({super.key, this.labelText});
  final String? labelText;

  @override
  Widget build(BuildContext context) {
    var signUpController = Get.put(SignUpController());
    final theme = Get.put(ThemeService()).fondueSwapTheme;
    return Obx(
      () => TextField(
        obscureText: signUpController.obscureText.value,
        style: FondueSwapConstants.fromColor(theme.mistyLavender).kRoboto16,
        decoration: InputDecoration(
          filled: true,
          fillColor: theme.graphite,
          labelText: labelText,
          labelStyle: FondueSwapConstants.fromColor(theme.mistyLavender).kRoboto16,
          suffixIcon: GestureDetector(
            onTap: () => signUpController.visiblePassword(),
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
