import 'package:flutter/material.dart';
import '../../widgets/fondue_bottom_navbar.dart';
import '../../widgets/fondue_scaffold.dart';
import 'package:get/get.dart';

import 'controllers/home_controller.dart';
import 'widgets/home_appbar.dart';

class HomePageLoader extends GetView<HomeController> {
  const HomePageLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return FondueScaffold(
      appBar: const HomeAppbar(),
      bottomNavigationBar: const FondueBottomNavbar(),
      body: Obx(() {
        return IndexedStack(
          index: controller.selectedIndex.value,
          children: controller.pages,
        );
      }),
    );
  }
}
