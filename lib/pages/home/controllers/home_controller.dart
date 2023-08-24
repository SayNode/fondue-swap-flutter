import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../pots/pots_page.dart';
import '../../settings/settings_page.dart';
import '../../swap/swap_page.dart';
import '../../wallet/wallet_page.dart';

class HomeController extends GetxController {
  RxInt selectedIndex = 0.obs;
  List<String> titles = ['Wallet', 'Swap', 'Pots', 'Settings'];
  List<Widget> pages = [
    const WalletPage(),
    const SwapPage(),
    const PotsPage(),
    const SettingsPage()
  ];
}
