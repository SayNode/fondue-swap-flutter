import 'package:flutter/material.dart';
import '../theme/constants.dart';
import 'package:get/get.dart';

import '../services/theme_service.dart';
import '../theme/custom_theme.dart';

class FondueAppbar extends StatelessWidget implements PreferredSizeWidget {
  const FondueAppbar({
    required this.title,
    super.key,
    this.height = kToolbarHeight,
  });

  final double height;
  final String title;

  @override
  Widget build(BuildContext context) {
    final FondueSwapTheme theme = Get.put(ThemeService()).fondueSwapTheme;
    return AppBar(
      centerTitle: true,
      title: Text(
        title,
        style: FondueSwapConstants.fromColor(theme.mistyLavender).kRoboto14,
      ),
      elevation: 0,
      backgroundColor: theme.midnightBlack,
      leading: BackButton(color: theme.mistyLavender),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
