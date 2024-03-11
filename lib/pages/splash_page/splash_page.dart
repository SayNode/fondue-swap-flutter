import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/fondue_scaffold.dart';
import '../login/login_page.dart';
import '../onboarding_pages/onboard_page_1.dart';
import 'controller/splash_controller.dart';

class SplashPage extends GetView<SplashPageController> {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashPageController());
    return FondueScaffold(
      body: Center(
        child: FutureBuilder<bool>(
          future: controller.initAsyncServices(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.hasData) {
              if (controller.hasAccount) {
                return const LoginPage();
              } else {
                return const OnboardingPage1();
              }
            } else if (snapshot.hasError) {
              debugPrint(snapshot.error.toString());
            }
            return const Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  width: 60,
                  height: 60,
                  child: CircularProgressIndicator(),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text('Awaiting result...'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
