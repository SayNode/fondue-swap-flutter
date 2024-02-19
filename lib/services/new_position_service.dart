import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:thor_request_dart/connect.dart';
import 'package:thor_request_dart/contract.dart';

import '../models/pool.dart';
import '../models/token.dart';
import '../utils/globals.dart';
import 'wallet_service.dart';

class NewPositionService extends GetxService {
  Connect connector = Connect(vechainNodeUrl);

  Rx<bool> fetchingPoolData = false.obs;

  RxDouble fee = 0.0.obs;

  Rx<Token?> tokenX = Rxn<Token>();
  Rx<Token?> tokenY = Rxn<Token>();

  RxDouble tokenXAmount = 0.0.obs;
  RxDouble tokenYAmount = 0.0.obs;

  RxDouble minPrice = 0.0.obs;
  RxDouble maxPrice = 0.0.obs;

  RxDouble sliderMax = 0.0.obs;
  RxDouble sliderMin = 0.0.obs;

  Rxn<Pool> pool = Rxn<Pool>();

  bool checkIfPoolSelected() {
    if (tokenX.value != null && tokenY.value != null && fee.value != 0.0) {
      return true;
    }
    return false;
  }

  Future<BigInt> calcTokenInputForLiquidity({
    required int lowerTick,
    required int upperTick,
    required BigInt amountIn,
  }) async {
    final Connect connector = Connect(vechainNodeUrl);
    final String abi =
        await rootBundle.loadString('assets/abi/quoter_abi.json');
    final Contract contract = Contract.fromJsonString(abi);
    final String userAddress = Get.find<WalletService>().wallet.value!.address;
    try {
      print('lowerTick: $lowerTick');
      print('upperTick: $upperTick');
      final Map<dynamic, dynamic> response = await connector.call(
        userAddress,
        contract,
        'quoteLiqInputToken0',
        <dynamic>[
          pool.value!.tokenX,
          pool.value!.tokenY,
          pool.value!.fee,
          BigInt.from(lowerTick),
          BigInt.from(upperTick),
          amountIn,
        ],
        quoterContract,
      );

      final Map<dynamic, dynamic> decoded =
          response['decoded'] as Map<dynamic, dynamic>;

      print('decoded: $decoded');
      return decoded[0] as BigInt;
    } catch (e) {
      print(e);
      return BigInt.zero;
    }
  }
}
