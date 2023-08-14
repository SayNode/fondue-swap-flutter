import 'package:flutter/material.dart';
import 'package:fondue_swap/pages/widgets/fondue_scaffold.dart';

class OnboardingFirstPage extends StatelessWidget {
  const OnboardingFirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const FondueScaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text(
              'Onboarding Page 1',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
