import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:thor_devkit_dart/utils.dart';
import 'package:thor_request_dart/connect.dart';
import 'package:thor_request_dart/contract.dart';
import 'package:thor_request_dart/wallet.dart';

import '../models/token.dart';
import '../utils/globals.dart';
import 'wallet_service.dart';

class SwapService extends GetxService {
  Connect connector = Connect(vechainNodeUrl);

  Rx<Token?> tokenX = Rxn<Token>();
  Rx<Token?> tokenY = Rxn<Token>();

  Future<void> getQuote({
    required String tokenXAddress,
    required String tokenYAddress,
    required BigInt amountX,
    required int poolFee,
    required BigInt maxPriceVariation,
  }) async {
    final String abi =
        await rootBundle.loadString('assets/abi/quoter_abi.json');
    final Contract contract = Contract.fromJsonString(abi);

    final Wallet wallet = Wallet(
      hexToBytes(
        '0x930c11cd7aa07d508f784c9c6f8ec8bb04c183f6c6ca05d8fa93c7c6f2950f28',
      ),
    );
    final List<dynamic> paramsList = <dynamic>[
      tokenXAddress,
      tokenYAddress,
      amountX,
      BigInt.from(poolFee),
      maxPriceVariation,
    ];
    final Map<dynamic, dynamic> res = await connector.transact(
      wallet,
      contract,
      'quoteSingle',
      paramsList,
      '0x860076a59604a37857967f6966254aef36d58e66',
    );
    print(res);
  }

  getCreatedPools({required String tokenX, required String tokenY}) async {
    final String abi =
        await rootBundle.loadString('assets/abi/pool_factory_abi.json');
    final Contract contract = Contract.fromJsonString(abi);
    final String userAddress = Get.find<WalletService>().wallet.value!.address;
    final Map<dynamic, dynamic> response = await connector.call(
      userAddress,
      contract,
      'getCreatedPools',
      <dynamic>[],
      poolFactoryContract,
    );
    print(response);
  }
}
