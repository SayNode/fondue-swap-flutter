import 'package:flutter/material.dart';
import 'package:fondue_swap/widgets/fondue_bottom_navbar.dart';
import 'package:fondue_swap/widgets/fondue_scaffold.dart';
import 'package:get/get.dart';

import 'controllers/home_controller.dart';

class HomePageLoader extends GetView<HomeController> {
  const HomePageLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return FondueScaffold(
        bottomNavigationBar: const FondueBottomNavbar(),
        body: Obx(() {
          return IndexedStack(
            index: controller.selectedIndex.value,
            children: controller.pages,
          );
        }));
  }
}
