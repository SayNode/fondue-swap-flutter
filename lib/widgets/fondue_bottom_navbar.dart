import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../pages/home/controllers/home_controller.dart';
import '../services/theme_service.dart';
import '../theme/constants.dart';

class FondueBottomNavbar extends GetView<HomeController> {
  const FondueBottomNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Get.put(ThemeService()).fondueSwapTheme;
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(12.0),
        topRight: Radius.circular(12.0),
      ),
      child: Container(
        height: 82,
        decoration: BoxDecoration(
          color: theme.graphite,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: const Align(
          alignment: Alignment.center,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              NavigationItem(
                image: 'assets/icons/wallet_icon.png',
                lable: 'Wallet',
                index: 0,
              ),
              NavigationItem(
                image: 'assets/icons/swap_icon.png',
                lable: 'Swap',
                index: 1,
              ),
              NavigationItem(
                image: 'assets/icons/pots_icon.png',
                lable: 'Pots',
                index: 2,
              ),
              NavigationItem(
                image: 'assets/icons/settings_icon.png',
                lable: 'Settings',
                index: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NavigationItem extends GetView<HomeController> {
  final String image;
  final String lable;
  final int index;

  const NavigationItem({
    super.key,
    required this.image,
    required this.lable,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Get.put(ThemeService()).fondueSwapTheme;

    return Obx(() {
      var color = (controller.selectedIndex.value == index)
          ? theme.goldenSunset
          : theme.mistyLavender;
      return MaterialButton(
        minWidth: 0,
        onPressed: () => controller.selectedIndex.value = index,
        //behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                image,
                height: 24,
                color: color,
              ),
              Text(
                lable.tr,
                style: FondueSwapConstants.fromColor(color).kRoboto14,
              ),
            ],
          ),
        ),
      );
    });
  }
}
