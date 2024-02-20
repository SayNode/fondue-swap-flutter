import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:thor_request_dart/connect.dart';
import 'package:thor_request_dart/contract.dart';
import 'package:thor_request_dart/wallet.dart' as thor_wallet;
import 'package:web3dart/credentials.dart';

import '../models/pool.dart';
import '../models/token.dart';
import '../utils/globals.dart';
import '../utils/pool_util.dart';
import 'wallet_service.dart';

class NewPositionService extends GetxService {
  Connect connector = Connect(vechainNodeUrl);

  Rx<bool> fetchingPoolData = false.obs;

  RxInt slippage = 0.obs;

  RxDouble fee = 0.0.obs;

  Rx<Token?> tokenX = Rxn<Token>();
  Rx<Token?> tokenY = Rxn<Token>();

  RxDouble tokenXAmount = 0.0.obs;
  RxDouble tokenYAmount = 0.0.obs;

  RxDouble minPrice = 0.0.obs;
  RxDouble maxPrice = 0.0.obs;

  Rxn<Pool> pool = Rxn<Pool>();

  bool checkIfPoolSelected() {
    if (tokenX.value != null && tokenY.value != null && fee.value != 0.0) {
      return true;
    }
    return false;
  }

  Future<String> mintNewPosition({
    required String password,
    required int lowerTick,
    required int upperTick,
    required BigInt amount0Desired,
    required BigInt amount1Desired,
    required BigInt amount0Min,
    required BigInt amount1Min,
  }) async {
    final Connect connector = Connect(vechainNodeUrl);
    final String abi =
        await rootBundle.loadString('assets/abi/pool_nft_abi.json');
    final Contract contract = Contract.fromJsonString(abi);
    final thor_wallet.Wallet wallet =
        thor_wallet.Wallet(Get.find<WalletService>().getPrivateKey(password));
    final String userAddress = Get.find<WalletService>().wallet.value!.address;

    final String txId = await approveFunds(
      amount: amount0Desired,
      tokenAddress: tokenX.value!.tokenAddress,
      password: password,
      spender: EthereumAddress.fromHex(nftContractAddress),
    );
    final String txId2 = await approveFunds(
      amount: amount1Desired,
      tokenAddress: tokenY.value!.tokenAddress,
      password: password,
      spender: EthereumAddress.fromHex(nftContractAddress),
    );
    await waitForTxReceipt(txId);
    await waitForTxReceipt(txId2);
    try {
      final Map<dynamic, dynamic> response = await connector.transact(
        wallet,
        contract,
        'mint',
        <dynamic>[
          userAddress,
          pool.value!.tokenX,
          pool.value!.tokenY,
          pool.value!.fee,
          BigInt.from(lowerTick),
          BigInt.from(upperTick),
          amount0Desired,
          amount1Desired,
          amount0Min,
          amount1Min,
        ],
        nftContractAddress,
      );

      return response['id'] as String;
    } catch (e) {
      rethrow;
    }
  }

  Future<BigInt> calcTokenInputForLiquidity({
    required int lowerTick,
    required int upperTick,
    required BigInt amountIn,
    required bool xToY,
  }) async {
    final Connect connector = Connect(vechainNodeUrl);
    final String abi =
        await rootBundle.loadString('assets/abi/quoter_abi.json');
    final Contract contract = Contract.fromJsonString(abi);
    final String userAddress = Get.find<WalletService>().wallet.value!.address;
    try {
      final Map<dynamic, dynamic> response = await connector.call(
        userAddress,
        contract,
        (xToY ? 'quoteLiqInputToken0' : 'quoteLiqInputToken1'),
        <dynamic>[
          if (xToY) pool.value!.tokenX else pool.value!.tokenY,
          if (xToY) pool.value!.tokenY else pool.value!.tokenX,
          pool.value!.fee,
          BigInt.from(lowerTick),
          BigInt.from(upperTick),
          amountIn,
        ],
        quoterContract,
      );

      final Map<dynamic, dynamic> decoded =
          response['decoded'] as Map<dynamic, dynamic>;
      return decoded[0] as BigInt;
    } catch (e) {
      return BigInt.zero;
    }
  }
}
