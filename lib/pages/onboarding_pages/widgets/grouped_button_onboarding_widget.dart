import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../services/theme_service.dart';
import '../../../theme/constants.dart';
import '../../../theme/custom_theme.dart';

class GroupedButtonOnboarding extends StatelessWidget {
  const GroupedButtonOnboarding({
    required this.slide,
    required this.onTapButton,
    required this.onTapTextButton,
    super.key,
  });

  final String slide;
  final void Function()? onTapButton;
  final void Function()? onTapTextButton;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final FondueSwapTheme fondueSwapTheme =
        Get.put(ThemeService()).fondueSwapTheme;
    return Column(
      children: <Widget>[
        Image.asset(
          slide,
          scale: 4,
        ),
        SizedBox(height: screenSize.height * 0.01),
        GestureDetector(
          onTap: onTapButton.call,
          child: SvgPicture.asset('assets/icons/orange_button.svg'),
        ),
        GestureDetector(
          onTap: onTapTextButton.call,
          child: Text(
            'Skip introduction'.tr,
            style: FondueSwapConstants.fromColor(fondueSwapTheme.mistyLavender)
                .kRoboto14,
          ),
        ),
      ],
    );
  }
}
