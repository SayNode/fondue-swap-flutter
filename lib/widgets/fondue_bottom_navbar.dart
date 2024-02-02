import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../pages/home/controllers/home_controller.dart';
import '../services/theme_service.dart';
import '../theme/constants.dart';
import '../theme/custom_theme.dart';

class FondueBottomNavbar extends GetView<HomeController> {
  const FondueBottomNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    final FondueSwapTheme theme = Get.put(ThemeService()).fondueSwapTheme;
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(12),
        topRight: Radius.circular(12),
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
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
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
  const NavigationItem({
    required this.image,
    required this.lable,
    required this.index,
    super.key,
  });
  final String image;
  final String lable;
  final int index;

  @override
  Widget build(BuildContext context) {
    final FondueSwapTheme theme = Get.put(ThemeService()).fondueSwapTheme;

    return Obx(() {
      final Color color = (controller.selectedIndex.value == index)
          ? theme.goldenSunset
          : theme.mistyLavender;
      return MaterialButton(
        minWidth: 0,
        onPressed: () => controller.selectedIndex.value = index,
        //behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: const EdgeInsets.all(3),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
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
