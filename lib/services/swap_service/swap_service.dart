import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:thor_request_dart/connect.dart';
import 'package:thor_request_dart/contract.dart';
import 'package:web3dart/web3dart.dart' show EthereumAddress;

import '../../models/pool.dart';
import '../../models/token.dart';
import '../../utils/globals.dart';
import '../../utils/util.dart';
import '../wallet_service.dart';
import 'exceptions.dart';

class SwapService extends GetxService {
  Connect connector = Connect(vechainNodeUrl);

  Rx<Token?> tokenX = Rxn<Token>();
  Rx<Token?> tokenY = Rxn<Token>();
  RxInt slippage = 0.obs;
  Rx<BigInt> amountX = BigInt.zero.obs;
  Rx<BigInt> amountY = BigInt.zero.obs;

  RxBool fetchingPrice = false.obs;

  Future<BigInt> getQuote({
    required String tokenXAddress,
    required String tokenYAddress,
    required BigInt amountX,
    required BigInt poolFee,
    required BigInt maxPriceVariation,
  }) async {
    final String userAddress = Get.find<WalletService>().wallet.value!.address;
    final String abi =
        await rootBundle.loadString('assets/abi/quoter_abi.json');
    final Contract contract = Contract.fromJsonString(abi);

    final List<dynamic> paramsList = <dynamic>[
      tokenXAddress,
      tokenYAddress,
      poolFee,
      amountX,
      maxPriceVariation,
    ];
    final Map<dynamic, dynamic> res = await connector.call(
      userAddress,
      contract,
      'quoteSingle',
      paramsList,
      quoterContract,
    );
    print(res);
    return (res['decoded'] as Map<dynamic, dynamic>)[0] as BigInt;
  }

  Future<BigInt> getSqrtPriceX96(String contractAddress) async {
    final String abi = await rootBundle.loadString('assets/abi/pool_abi.json');
    final Contract contract = Contract.fromJsonString(abi);
    final String userAddress = Get.find<WalletService>().wallet.value!.address;
    final Map<dynamic, dynamic> response = await connector.call(
      userAddress,
      contract,
      'slot0',
      <dynamic>[],
      contractAddress,
    );
    return (response['decoded'] as Map<dynamic, dynamic>)[0] as BigInt;
  }

  Future<BigInt> fetchBestPrice() async {
    assert(
      tokenX.value != null &&
          tokenY.value != null &&
          slippage.value != 0 &&
          amountX.value != BigInt.zero,
      'TokenX, TokenY, slippage and amountX must not be null or zero.',
    );
    final Map<String, BigInt> quoteMap = <String, BigInt>{};
    print('staring to fetch best price	');
    final List<Pool> poolList = await getCreatedPools(
      tokenX: tokenX.value!.tokenAddress,
      tokenY: tokenY.value!.tokenAddress,
    );
    print('pool list: $poolList');
    if (poolList.isNotEmpty) {
      for (final Pool pool in poolList) {
        pool.address = await getPoolAddress(pool: pool);

        final BigInt squrPriceX96 = await getSqrtPriceX96(pool.address!);
        final BigInt maxPriceVariation = multiplyBigintWithDouble(
          squrPriceX96,
          1 - (slippage.value / 100),
        );

        final BigInt quote = await getQuote(
          tokenXAddress: tokenX.value!.tokenAddress,
          tokenYAddress: tokenY.value!.tokenAddress,
          amountX: amountX.value,
          poolFee: pool.fee,
          maxPriceVariation: maxPriceVariation,
        );
        print('quote: $quote');
        quoteMap[pool.address!] = quote;
      }
    } else {
      throw NoPoolFoundException('No pool found for the given token pair.');
    }
    print('quoteMap: $quoteMap');
    final BigInt bestQuote = quoteMap.values.reduce(
      (BigInt value, BigInt element) => value < element ? value : element,
    );
    return bestQuote;
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
