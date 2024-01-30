import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../services/theme_service.dart';
import '../../../theme/constants.dart';
import '../../../theme/custom_theme.dart';
import '../../../widgets/fondue_appbar.dart';
import '../../../widgets/fondue_button.dart';
import '../../../widgets/fondue_scaffold.dart';
import 'generated_seed_page.dart';
import 'widgets/security_text.dart';

class SeedSecurityRulesPage extends StatelessWidget {
  const SeedSecurityRulesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final FondueSwapTheme theme = Get.put(ThemeService()).fondueSwapTheme;

    return FondueScaffold(
      appBar: FondueAppbar(title: 'Create Wallet'.tr),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Text(
                'Vital seed phrase security rules',
                style: FondueSwapConstants.fromColor(theme.mistyLavender)
                    .kRoboto22,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                'Safeguard your seed phrase with these essential guidelines',
                textAlign: TextAlign.center,
                style: FondueSwapConstants.fromColor(theme.mistyLavender)
                    .kRoboto14,
              ),
              const SizedBox(
                height: 84,
              ),
              const SecurityText(
                title: 'Physical storage only: ',
                description:
                    'Keep your seed phrase offline and in a physical form. Never store it digitally or on devices connected to the internet.',
              ),
              const SizedBox(
                height: 10,
              ),
              const SecurityText(
                title: 'Multiple secure copies: ',
                description:
                    'Create multiple handwritten or printed copies of your seed phrase. Store them in separate, secure locations to prevent loss.',
              ),
              const SizedBox(
                height: 10,
              ),
              const SecurityText(
                title: 'Private and hidden: ',
                description:
                    'Create multiple handwritten or printed copies of your seed phrase. Store them in separate, secure locations to prevent loss.',
              ),
              const SizedBox(
                height: 10,
              ),
              const SecurityText(
                title: 'Beware of Sharing: ',
                description:
                    'Never share your seed phrase with anyone, online or offline. Legitimate services will never ask for your seed phrase.',
              ),
              const SizedBox(
                height: 10,
              ),
              const SecurityText(
                title: 'Plan for Inheritance: ',
                description:
                    'If something happens to you, ensure your loved ones know how to access your seed phrase securely. Consider a trusted individual or instructions in your will.',
              ),
              const SizedBox(
                height: 50,
              ),
              //const Spacer(),
              FondueButton(
                expanded: true,
                text: 'Create wallet',
                onTap: () =>
                    <Future<dynamic>?>{Get.to(() => const GeneratedSeedPage())},
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.08,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
