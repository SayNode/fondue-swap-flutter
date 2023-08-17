import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fondue_swap/pages/signup_pages.dart/controller/signup_controller.dart';
import 'package:fondue_swap/pages/widgets/fondue_appbar.dart';
import 'package:fondue_swap/pages/widgets/fondue_scaffold.dart';
import 'package:fondue_swap/pages/widgets/fondue_textfield.dart';
import 'package:fondue_swap/theme/colors.dart';
import 'package:get/get.dart';

import '../../services/theme_service.dart';
import '../../theme/constants.dart';
import '../../utils/password.dart';

class CreatePasswordPage extends StatelessWidget {
  const CreatePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Get.put(ThemeService()).fondueSwapTheme;
    var screenSize = MediaQuery.of(context).size;
    var signUpController = Get.put(SignUpController());
    return FondueScaffold(
      appBar: FondueAppbar(
        title: 'Password'.tr,
      ),
      body: Column(
        children: [
          Text('Set up your password'.tr, style: FondueSwapConstants.fromColor(theme.mistyLavender).kRoboto22),
          SizedBox(height: screenSize.height * 0.005),
          Text(
            'Strengthening your digital fortress'.tr,
            style: FondueSwapConstants.fromColor(theme.mistyLavender).kRoboto14,
          ),
          SizedBox(height: screenSize.height * 0.035),
          Align(
            alignment: Alignment.centerLeft,
            child: Text('Password'.tr, style: FondueSwapConstants.fromColor(theme.mistyLavender).kRoboto14),
          ),
          SizedBox(height: screenSize.height * 0.01),
          FondueTextField(
            labelText: 'Enter Your Password'.tr,
            controller: signUpController.passwordController,
            onChanged: (value) {
              int strengthIndex = determinePasswordStrength(signUpController.passwordController.text);
              signUpController.passwordStrength.update(strengthIndex);
              signUpController.updateMatch();
            },
          ),
          SizedBox(height: screenSize.height * 0.015),
          Align(
            alignment: Alignment.centerLeft,
            child: Text('Confirm Password'.tr, style: FondueSwapConstants.fromColor(theme.mistyLavender).kRoboto14),
          ),
          SizedBox(height: screenSize.height * 0.005),
          FondueTextField(
            labelText: 'Enter Your Password'.tr,
            controller: signUpController.confirmPasswordController,
            onChanged: (value) {
              signUpController.updateMatch();
            },
          ),
          Row(
            children: [
              Column(
                children: [
                  Row(
                    children: [SvgPicture.asset('assets/icons/grey_tick.svg')],
                  )
                ],
              ),
              Column(
                children: [
                  Row(
                    children: [],
                  )
                ],
              )
            ],
          ),
          SizedBox(height: screenSize.height * 0.07),
          Card(
            color: theme.graphite,
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.03, vertical: screenSize.height * 0.02),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Enable Biometric'.tr, style: FondueSwapConstants.fromColor(theme.mistyLavender).kRoboto14),
                      SizedBox(height: screenSize.height * 0.01),
                      SizedBox(width: screenSize.width * 0.6, child: Text('Enhancing Security and Streamlining Access with Biometric Technology'.tr, style: FondueSwapConstants.fromColor(theme.mistyLavender).kRoboto14)),
                    ],
                  ),
                ),
                SizedBox(width: screenSize.width * 0.09),
                CupertinoSwitch(
                  value: true,
                  onChanged: (value) {},
                  activeColor: theme.goldenSunset,
                ),
              ],
            ),
          ),
          SizedBox(height: screenSize.height * 0.2),
          SizedBox(
            width: screenSize.width * 0.18,
            child: ElevatedButton(
              onPressed: signUpController.isButtonEnabled.value ? () {} : null,
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                backgroundColor: FondueSwapColor.graphite,
                side: BorderSide(color: signUpController.isButtonEnabled.value ? FondueSwapColor.goldenSunset : FondueSwapColor.graphite, width: 2),
              ),
              child: Text('Next'.tr, style: FondueSwapConstants.fromColor(signUpController.isButtonEnabled.value ? theme.goldenSunset : theme.graphite).kRoboto14),
            ),
          ),
        ],
      ),
    );
  }
}
