import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../services/theme_service.dart';
import '../../theme/constants.dart';
import '../../theme/custom_theme.dart';
import '../../utils/util.dart';
import '../../widgets/fondue_button.dart';
import '../../widgets/fondue_scaffold.dart';
import '../home/widgets/home_appbar.dart';
import 'widgets/fee_selection_widget/fee_selection_widget.dart';
import 'widgets/price_range_welector_widget/price_range_selector_widget.dart';
import 'widgets/price_range_welector_widget/token_amount_textfield.dart';
import 'widgets/select_token_widget/select_token_widget.dart';

class NewPositionPage extends StatelessWidget {
  const NewPositionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final FondueSwapTheme theme = Get.put(ThemeService()).fondueSwapTheme;
    return FondueScaffold(
      appBar: const HomeAppbar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Select pair',
              style:
                  FondueSwapConstants.fromColor(theme.mistyLavender).kRoboto16,
            ),
            const SelectTokenWidget(),
            SizedBox(
              height: getRelativeHeight(16),
            ),
            const FeeSelectionWidget(),
            SizedBox(
              height: getRelativeHeight(16),
            ),
            const PriceRangeSelectorWidget(),
            SizedBox(
              height: getRelativeHeight(16),
            ),
            Text(
              'Deposit amount',
              style:
                  FondueSwapConstants.fromColor(theme.mistyLavender).kRoboto16,
            ),
            const SizedBox(
              height: 8,
            ),
            TokenAmountTextField(controller: TextEditingController()),
            SizedBox(
              height: getRelativeHeight(16),
            ),
            TokenAmountTextField(controller: TextEditingController()),
            SizedBox(
              height: getRelativeHeight(70),
            ),
            FondueButton(text: 'Pool now', onTap: () {}),
          ],
        ),
      ),
    );
  }
}
