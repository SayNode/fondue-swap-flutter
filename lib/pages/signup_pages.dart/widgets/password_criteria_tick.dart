import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../models/password/password_criteria.dart';
import '../../../services/theme_service.dart';
import '../../../theme/constants.dart';
import 'package:get/get.dart';

import '../../../theme/custom_theme.dart';

class PasswordCriteriaTick extends StatelessWidget {
  const PasswordCriteriaTick({
    required this.criteria,
    super.key,
  });
  final PasswordCriteria criteria;

  @override
  Widget build(BuildContext context) {
    final FondueSwapTheme theme = Get.put(ThemeService()).fondueSwapTheme;
    final Size screenSize = MediaQuery.of(context).size;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SvgPicture.asset(
          criteria.validated
              ? 'assets/icons/green_tick.svg'
              : 'assets/icons/grey_tick.svg',
          width: screenSize.width * 0.045,
          height: screenSize.width * 0.045,
        ),
        SizedBox(width: screenSize.width * 0.01),
        Text(
          criteria.name,
          style: FondueSwapConstants.fromColor(theme.mistyLavender).kRoboto10,
        ),
      ],
    );
  }
}
