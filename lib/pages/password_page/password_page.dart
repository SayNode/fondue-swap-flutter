import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../services/theme_service.dart';
import '../../theme/constants.dart';
import '../../theme/custom_theme.dart';
import '../../widgets/fondue_appbar.dart';
import '../../widgets/fondue_button.dart';
import '../../widgets/fondue_scaffold.dart';
import '../../widgets/fondue_textfield.dart';
import 'controllers/password_controller.dart';

class PasswordPage extends GetView<PasswordController> {
  const PasswordPage({
    required this.submit,
    super.key,
  });

  final void Function(String) submit;

  @override
  Widget build(BuildContext context) {
    final FondueSwapTheme theme = Get.put(ThemeService()).fondueSwapTheme;
    final PasswordController passwordController = Get.put(PasswordController());
    // ignore: cascade_invocations
    passwordController.passedFunction = submit;
    final Size screenSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: FondueScaffold(
        appBar: FondueAppbar(title: 'Password'.tr),
        body: Column(
          children: <Widget>[
            SizedBox(
              width: double.infinity,
              child: Column(
                children: <Widget>[
                  SizedBox(height: screenSize.height * 0.035),
                  Text(
                    'Enter your password'.tr,
                    style: FondueSwapConstants.fromColor(theme.mistyLavender)
                        .kRoboto22,
                  ),
                  SizedBox(height: screenSize.height * 0.01),
                  Text(
                    'Safeguarding your digital identity'.tr,
                    style: FondueSwapConstants.fromColor(theme.mistyLavender)
                        .kRoboto14,
                  ),
                  SizedBox(height: screenSize.height * 0.05),
                ],
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Password'.tr,
                style: FondueSwapConstants.fromColor(theme.mistyLavender)
                    .kRoboto14,
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
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            SvgPicture.asset(
                              'assets/icons/exclamation_mark.svg',
                            ),
                            SizedBox(width: screenSize.width * 0.02),
                            Text(
                              'Invalid Password'.tr,
                              style:
                                  FondueSwapConstants.fromColor(theme.cherryRed)
                                      .kRoboto14,
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
                text: 'Login'.tr,
                onTap: () => controller.submit(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
