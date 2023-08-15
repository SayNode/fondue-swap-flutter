import 'package:flutter/material.dart';
import 'package:fondue_swap/theme/constants.dart';
import 'package:get/get.dart';

import '../../services/theme_service.dart';

class FondueAppbar extends StatelessWidget implements PreferredSizeWidget {
  const FondueAppbar({
    super.key,
    this.height = kToolbarHeight,
    required this.title,
  });

  final double height;
  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = Get.put(ThemeService()).fondueSwapTheme;
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
