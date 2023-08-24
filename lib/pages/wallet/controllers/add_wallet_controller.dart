import 'package:flutter/material.dart';
import 'package:fondue_swap/pages/wallet/create_wallet/create_wallet_page.dart';
import 'package:fondue_swap/pages/wallet/import_private_key_page.dart';
import 'package:fondue_swap/pages/wallet/import_seed_page.dart';
import 'package:get/get.dart';

import '../../../utils/add_wallet_options.dart';
import '../widgets/add_wallet_option_dialog.dart';

class AddWalletController extends GetxController {
  Future<void> choseAddWalletOptions() async {
    switch (await showDialog<AddWalletOptions>(
        context: Get.context!,
        builder: (BuildContext context) {
          return const AddWalletOptionsDialog();
        })) {
      case AddWalletOptions.createWallet:
        Get.to(() => const CreateWalletPage());
        break;
      case AddWalletOptions.importSeed:
        Get.to(() => const ImportSeedPage());
        break;
      case AddWalletOptions.importPrivateKey:
        Get.to(() => const ImportPrivateKeyPage());
        break;
      case null:
        // dialog dismissed
        break;
    }
  }
}
