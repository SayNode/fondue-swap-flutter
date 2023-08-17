import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fondue_swap/models/password/password_criteria.dart';
import 'package:fondue_swap/services/theme_service.dart';
import 'package:fondue_swap/theme/constants.dart';
import 'package:get/get.dart';

class PasswordCriteriaTick extends StatelessWidget {
  final PasswordCriteria criteria;
  const PasswordCriteriaTick({
    super.key,
    required this.criteria,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Get.put(ThemeService()).fondueSwapTheme;
    var screenSize = MediaQuery.of(context).size;
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          criteria.validated ? 'assets/icons/green_tick.svg' : 'assets/icons/grey_tick.svg',
          width: screenSize.width * 0.045,
          height: screenSize.width * 0.045,
        ),
        SizedBox(width: screenSize.width * 0.01),
        Text(
          criteria.name,
          style: FondueSwapConstants.fromColor(theme.mistyLavender).kRoboto10,
        )
      ],
    );
  }
}
