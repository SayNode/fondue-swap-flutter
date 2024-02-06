import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:thor_devkit_dart/utils.dart';
import 'package:thor_request_dart/connect.dart';
import 'package:thor_request_dart/contract.dart';
import 'package:thor_request_dart/wallet.dart';

import '../models/token.dart';
import '../utils/globals.dart';

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
    final Map<String, dynamic> paramsMap = <String, dynamic>{
      'tokenIn': tokenXAddress,
      'tokenOut': tokenYAddress,
      'amountIn': amountX,
      'fee': poolFee,
      'sqrtPriceLimitX96': maxPriceVariation,
    };
    final (String, String, BigInt, int, BigInt) paramsTuple =
        (tokenXAddress, tokenYAddress, amountX, poolFee, maxPriceVariation);

    final List<dynamic> paramsList = <dynamic>[
      tokenXAddress,
      tokenYAddress,
      amountX,
      poolFee,
      maxPriceVariation,
    ];
    final Map<dynamic, dynamic> res = await connector.transact(
      wallet,
      contract,
      'quoteSingle',
      <dynamic>[paramsTuple],
      '0x20887f1250Fa494d4785500Db760236Bfc54c725',
    );
    print(res);
  }
}
