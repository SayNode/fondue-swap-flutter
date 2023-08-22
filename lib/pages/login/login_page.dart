import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fondue_swap/widgets/fondue_appbar.dart';
import 'package:fondue_swap/widgets/fondue_button.dart';
import 'package:fondue_swap/widgets/fondue_scaffold.dart';
import 'package:fondue_swap/widgets/fondue_textfield.dart';
import 'package:get/get.dart';

import '../../services/theme_service.dart';
import '../../theme/constants.dart';
import 'controller/login_controller.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LoginController());
    final theme = Get.put(ThemeService()).fondueSwapTheme;
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
            FondueTextField(
              hintText: 'Enter Your Password'.tr,
              controller: controller.passwordController,
              passwordTextField: true,
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
              child: FondueButton(
                text: "Login".tr,
                onTap: controller.submit,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
