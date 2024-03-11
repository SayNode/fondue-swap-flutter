import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/add_wallet_options.dart';
import '../create_wallet/create_wallet_page.dart';
import '../import_private_key_page.dart';
import '../import_seed_page.dart';
import '../widgets/add_wallet_option_dialog.dart';

class AddWalletController extends GetxController {
  Future<void> choseAddWalletOptions() async {
    switch (await showDialog<AddWalletOptions>(
      context: Get.context!,
      builder: (BuildContext context) {
        return const AddWalletOptionsDialog();
      },
    )) {
      case AddWalletOptions.createWallet:
        await Get.to<Widget>(() => const CreateWalletPage());
      case AddWalletOptions.importSeed:
        await Get.to<Widget>(() => const ImportSeedPage());
      case AddWalletOptions.importPrivateKey:
        await Get.to<Widget>(() => const ImportPrivateKeyPage());
      case null:
        // dialog dismissed
        break;
    }
  }
}
