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
    return FondueScaffold(
      appBar: const FondueAppbar(
        title: 'Password',
      ),
      body: Column(
        children: [
          Text(
            'Set up your password',
            style: FondueSwapConstants.fromColor(theme.mistyLavender).kRoboto22,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            'Strengthening your digital fortress',
            style: FondueSwapConstants.fromColor(theme.mistyLavender).kRoboto14,
          ),
          const SizedBox(
            height: 38,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Password',
              style: FondueSwapConstants.fromColor(theme.mistyLavender).kRoboto14,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          const FondueTextfield(
            labelText: 'Password',
          ),
          const SizedBox(
            height: 16,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Confirm Password',
              style: FondueSwapConstants.fromColor(theme.mistyLavender).kRoboto14,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          const FondueTextfield(
            labelText: 'Password',
          ),
        ],
      ),
    );
  }
}
