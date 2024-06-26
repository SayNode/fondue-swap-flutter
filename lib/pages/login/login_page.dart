import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../widgets/fondue_appbar.dart';
import '../../widgets/fondue_button.dart';
import '../../widgets/fondue_scaffold.dart';
import '../../widgets/fondue_textfield.dart';
import 'package:get/get.dart';

import '../../services/theme_service.dart';
import '../../theme/constants.dart';
import '../../theme/custom_theme.dart';
import 'controller/login_controller.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LoginController());
    final FondueSwapTheme theme = Get.put(ThemeService()).fondueSwapTheme;
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
            Expanded(
              child: Obx(
                () => controller.isBiometricsOn.value
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            'or'.tr,
                            style: FondueSwapConstants.fromColor(
                              theme.mistyLavender,
                            ).kRoboto14,
                          ),
                          Material(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(256),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(256),
                              onTap: () => controller.biometricsLogin(),
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: SvgPicture.asset(
                                  'assets/icons/fingerprint.svg',
                                  width: screenSize.width * 0.28,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : const SizedBox.expand(),
              ),
            ),
            SizedBox(
              width: screenSize.width * 0.95,
              child: FondueButton(
                text: 'Login'.tr,
                onTap: controller.submit,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
