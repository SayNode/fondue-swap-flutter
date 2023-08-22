import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../services/theme_service.dart';
import '../../theme/constants.dart';
import '../../widgets/fondue_appbar.dart';
import '../../widgets/fondue_button_small.dart';
import '../../widgets/fondue_password_textfield.dart';
import '../../widgets/fondue_scaffold.dart';
import 'controllers/password_controller.dart';

class PasswordPage extends GetView<PasswordController> {
  const PasswordPage({
    super.key,
    required this.submit,
  });

  final void Function(String) submit;

  @override
  Widget build(BuildContext context) {
    final theme = Get.put(ThemeService()).fondueSwapTheme;
    var passwordController = Get.put(PasswordController());
    passwordController.passedFunction = submit;
    var screenSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: FondueScaffold(
        appBar: FondueAppbar(title: 'Password'.tr),
        body: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: screenSize.height * 0.035),
                  Text(
                    'Enter your password'.tr,
                    style: FondueSwapConstants.fromColor(theme.mistyLavender).kRoboto22,
                  ),
                  SizedBox(height: screenSize.height * 0.01),
                  Text(
                    'Safeguarding your digital identity'.tr,
                    style: FondueSwapConstants.fromColor(theme.mistyLavender).kRoboto14,
                  ),
                  SizedBox(height: screenSize.height * 0.05),
                ],
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Password'.tr,
                style: FondueSwapConstants.fromColor(theme.mistyLavender).kRoboto14,
              ),
            ),
            SizedBox(height: screenSize.height * 0.01),
            FonduePasswordTextField(
              labelText: 'Enter Your Password'.tr,
              controller: controller.passwordController,
              onChanged: (value) {},
            ),
            SizedBox(height: screenSize.height * 0.02),
            Obx(
              () => !controller.validPassword.value
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset('assets/icons/exclamation_mark.svg'),
                            SizedBox(width: screenSize.width * 0.02),
                            Text(
                              'Invalid Password'.tr,
                              style: FondueSwapConstants.fromColor(theme.cherryRed).kRoboto14,
                            ),
                          ],
                        ),
                        SvgPicture.asset('assets/icons/question_mark.svg'),
                      ],
                    )
                  : Container(),
            ),
            SizedBox(height: screenSize.height * 0.45),
            SizedBox(
              width: screenSize.width * 0.95,
              child: SmallFondueButton(
                text: "Login".tr,
                onTap: () => controller.submit(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
