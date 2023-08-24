import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fondue_swap/pages/signup_pages.dart/controller/signup_controller.dart';
import 'package:fondue_swap/pages/signup_pages.dart/widgets/password_criteria_tick.dart';
import 'package:fondue_swap/widgets/fondue_appbar.dart';
import 'package:fondue_swap/widgets/fondue_button.dart';
import 'package:fondue_swap/widgets/fondue_scaffold.dart';
import 'package:get/get.dart';

import '../../services/theme_service.dart';
import '../../theme/constants.dart';
import '../../widgets/fondue_textfield.dart';

class CreatePasswordPage extends GetView<SignUpController> {
  const CreatePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Get.put(ThemeService()).fondueSwapTheme;
    var screenSize = MediaQuery.of(context).size;
    Get.put(SignUpController());
    return FondueScaffold(
      appBar: FondueAppbar(title: 'Password'.tr),
      body: Column(
        children: [
          Text('Set up your password'.tr,
              style:
                  FondueSwapConstants.fromColor(theme.mistyLavender).kRoboto22),
          SizedBox(height: screenSize.height * 0.005),
          Text(
            'Strengthening your digital fortress'.tr,
            style: FondueSwapConstants.fromColor(theme.mistyLavender).kRoboto14,
          ),
          SizedBox(height: screenSize.height * 0.035),
          Align(
            alignment: Alignment.centerLeft,
            child: Text('Password'.tr,
                style: FondueSwapConstants.fromColor(theme.mistyLavender)
                    .kRoboto14),
          ),
          SizedBox(height: screenSize.height * 0.01),
          FondueTextField(
            hintText: 'Enter Your Password'.tr,
            controller: controller.passwordController,
            onChanged: controller.onPasswordChanged1,
            passwordTextField: true,
          ),
          SizedBox(height: screenSize.height * 0.015),
          Align(
            alignment: Alignment.centerLeft,
            child: Text('Confirm Password'.tr,
                style: FondueSwapConstants.fromColor(theme.mistyLavender)
                    .kRoboto14),
          ),
          SizedBox(height: screenSize.height * 0.005),
          FondueTextField(
            passwordTextField: true,
            hintText: 'Enter Your Password'.tr,
            controller: controller.confirmPasswordController,
            onChanged: controller.onPasswordChanged2,
          ),
          SizedBox(height: screenSize.height * 0.02),
          Obx(
            () => Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: PasswordCriteriaTick(
                          criteria: controller.passwordStrength.criteria[0]),
                    ),
                    Expanded(
                      child: PasswordCriteriaTick(
                          criteria: controller.passwordStrength.criteria[1]),
                    ),
                  ],
                ),
                SizedBox(height: screenSize.height * 0.01),
                Row(
                  children: [
                    Expanded(
                      child: PasswordCriteriaTick(
                          criteria: controller.passwordStrength.criteria[2]),
                    ),
                    Expanded(
                      child: PasswordCriteriaTick(
                          criteria: controller.passwordStrength.criteria[3]),
                    ),
                  ],
                ),
                SizedBox(height: screenSize.height * 0.01),
                Row(
                  children: [
                    Expanded(
                      child: PasswordCriteriaTick(
                          criteria: controller.passwordStrength.criteria[4]),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: screenSize.height * 0.04),
          Card(
            color: theme.graphite,
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenSize.width * 0.03,
                        vertical: screenSize.height * 0.02),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Enable Biometric'.tr,
                          style:
                              FondueSwapConstants.fromColor(theme.mistyLavender)
                                  .kRoboto14,
                        ),
                        SizedBox(height: screenSize.height * 0.01),
                        SizedBox(
                          width: screenSize.width * 0.6,
                          child: Text(
                            'Enhancing Security and Streamlining Access with Biometric Technology'
                                .tr,
                            style: FondueSwapConstants.fromColor(
                                    theme.mistyLavender)
                                .kRoboto14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    0.0,
                    screenSize.height * 0.02,
                    screenSize.width * 0.03,
                    screenSize.height * 0.02,
                  ),
                  child: Obx(
                    () => CupertinoSwitch(
                      value: controller.isBiometricsEnabled.value,
                      onChanged: controller.onBiometricsSwitchChange,
                      activeColor: theme.goldenSunset,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: screenSize.height * 0.08),
          Obx(
            () => SizedBox(
              width: screenSize.width * 0.9,
              child: FondueButton(
                text: 'Next'.tr,
                disabled: controller.isButtonLocked.value,
                onTap: controller.onButtonTap,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
