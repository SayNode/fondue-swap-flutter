import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:thor_devkit_dart/utils.dart';
import 'package:thor_request_dart/connect.dart';
import 'package:thor_request_dart/contract.dart';
import 'package:thor_request_dart/wallet.dart';
import 'package:web3dart/web3dart.dart' show EthereumAddress;

import '../../models/pool.dart';
import '../../models/token.dart';
import '../../utils/globals.dart';
import '../wallet_service.dart';
import 'exceptions.dart';

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

  ///Function to get all pools for a given token pair from the pool factory contract.
  Future<List<Pool>> getCreatedPools({
    required String tokenX,
    required String tokenY,
  }) async {
    final String abi =
        await rootBundle.loadString('assets/abi/pool_factory_abi.json');
    final Contract contract = Contract.fromJsonString(abi);
    final String userAddress = Get.find<WalletService>().wallet.value!.address;
    try {
      final Map<dynamic, dynamic> response = await connector.call(
        userAddress,
        contract,
        'getCreatedPools',
        <dynamic>[],
        poolFactoryContract,
      );

      final Map<dynamic, dynamic> decoded =
          response['decoded'] as Map<dynamic, dynamic>;

      final List<EthereumAddress> tokenXList =
          (decoded[0] as List<dynamic>).cast<EthereumAddress>();
      final List<EthereumAddress> tokenYList =
          (decoded[1] as List<dynamic>).cast<EthereumAddress>();
      final List<BigInt> feeList = (decoded[2] as List<dynamic>).cast<BigInt>();
      final List<Pool> allPoolsList = <Pool>[];
      if (tokenYList.length != tokenYList.length ||
          tokenXList.length != feeList.length) {
        throw InvalidDataInContractException(
          'Invalid data in contract: getCreatedPools function response is not consistent.',
        );
      }
      for (int i = 0; i < feeList.length; i++) {
        allPoolsList.add(
          Pool(
            tokenX: tokenXList[i].hex,
            tokenY: tokenYList[i].hex,
            fee: feeList[i],
          ),
        );
      }
      return allPoolsList
          .where(
            (Pool pool) =>
                pool.tokenX == tokenX && pool.tokenY == tokenY ||
                pool.tokenY == tokenX && pool.tokenX == tokenY,
          )
          .toList();
    } on InvalidDataInContractException catch (e) {
      print(e);
      return <Pool>[];
    } on Exception catch (e) {
      print(e);
      return <Pool>[];
    }
  }

  Future<String> getPoolAddress({
    required Pool pool,
  }) async {
    final String abi =
        await rootBundle.loadString('assets/abi/pool_factory_abi.json');
    final Contract contract = Contract.fromJsonString(abi);
    final String userAddress = Get.find<WalletService>().wallet.value!.address;
    final Map<dynamic, dynamic> response = await connector.call(
      userAddress,
      contract,
      'pools',
      <dynamic>[
        pool.tokenX,
        pool.tokenY,
        pool.fee,
      ],
      poolFactoryContract,
    );
    return ((response['decoded'] as Map<dynamic, dynamic>)[0]
            as EthereumAddress)
        .hex;
  }
}
