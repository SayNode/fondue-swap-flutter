import 'package:flutter/material.dart';
import 'package:fondue_swap/pages/widgets/fondue_scaffold.dart';

class OnboardingFirstPage extends StatelessWidget {
  const OnboardingFirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FondueScaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text(
              't',
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
