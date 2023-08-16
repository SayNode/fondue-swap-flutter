import 'package:flutter/material.dart';
import 'package:fondue_swap/pages/widgets/fondue_appbar.dart';
import 'package:fondue_swap/pages/widgets/fondue_scaffold.dart';
import 'package:fondue_swap/pages/widgets/fondue_textfield.dart';
import 'package:get/get.dart';

import '../../services/theme_service.dart';
import '../../theme/constants.dart';

class CreatePasswordPage extends StatelessWidget {
  const CreatePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Get.put(ThemeService()).fondueSwapTheme;
    var screenSize = MediaQuery.of(context).size;
    return FondueScaffold(
      appBar: FondueAppbar(
        title: 'Password'.tr,
      ),
      body: Column(
        children: [
          Text(
            'Set up your password',
            style: FondueSwapConstants.fromColor(theme.mistyLavender).kRoboto22,
          ),
          SizedBox(
            height: screenSize.height * 0.005,
          ),
          Text(
            'Strengthening your digital fortress',
            style: FondueSwapConstants.fromColor(theme.mistyLavender).kRoboto14,
          ),
          SizedBox(
            height: screenSize.height * 0.035,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Password',
              style: FondueSwapConstants.fromColor(theme.mistyLavender).kRoboto14,
            ),
          ),
          SizedBox(
            height: screenSize.height * 0.01,
          ),
          const FondueTextField(
            labelText: 'Password',
          ),
          SizedBox(
            height: screenSize.height * 0.015,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Confirm Password',
              style: FondueSwapConstants.fromColor(theme.mistyLavender).kRoboto14,
            ),
          ),
          SizedBox(
            height: screenSize.height * 0.005,
          ),
          const FondueTextField(
            labelText: 'Password',
          ),
        ],
      ),
    );
  }
}
