import 'dart:io';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:thor_request_dart/connect.dart';
import 'package:thor_request_dart/contract.dart';
import 'package:thor_request_dart/wallet.dart' as thor_wallet;
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
  BigInt poolFee = BigInt.zero;
  BigInt maxPriceVariation = BigInt.zero;
  RxDouble priceImpact = 0.0.obs;
  RxBool gotQuote = false.obs;

  void reset() {
    tokenX.value = null;
    tokenY.value = null;
    slippage.value = 0;
    amountX.value = BigInt.zero;
    amountY.value = BigInt.zero;
    fetchingPrice.value = false;
    poolFee = BigInt.zero;
    maxPriceVariation = BigInt.zero;
  }

  Future<String> approveFundsForSwap(
    BigInt amount,
    String tokenAddress,
    String password,
  ) async {
    final String abi = await rootBundle.loadString('assets/abi/token_abi.json');
    final Contract contract = Contract.fromJsonString(abi);
    final List<dynamic> paramsList = <dynamic>[
      EthereumAddress.fromHex(swapManagerContract),
      amount,
    ];
    final thor_wallet.Wallet wallet =
        thor_wallet.Wallet(Get.find<WalletService>().getPrivateKey(password));
    final Map<dynamic, dynamic> res = await connector.transact(
      wallet,
      contract,
      'approve',
      paramsList,
      tokenAddress,
    );
    print(res);
    return res['id'] as String;
  }

  ///   Wait for tx receipt, for several seconds
  ///   Returns the receipt or Null
  Future<Map<dynamic, dynamic>?> _waitForTxReceipt(
    String txId, {
    int timeout = 20,
  }) async {
    final int rounds = timeout; //how many attempts
    Map<dynamic, dynamic>? receipt;
    for (int i = 0; i < rounds; i++) {
      try {
        receipt = await connector.getTransactionReceipt(txId);
      } catch (_) {}

      if (receipt != null) {
        return receipt;
      } else {
        sleep(const Duration(seconds: 3)); // interval
      }
    }

    return null;
  }

  Future<String> swap({
    required String tokenXAddress,
    required String tokenYAddress,
    required BigInt amountX,
    required BigInt poolFee,
    required BigInt maxPriceVariation,
    required String password,
  }) async {
    final String txId =
        await approveFundsForSwap(amountX, tokenXAddress, password);
    await _waitForTxReceipt(txId);
    final String abi =
        await rootBundle.loadString('assets/abi/swap_manager_abi.json');
    final Contract contract = Contract.fromJsonString(abi);

    final List<dynamic> paramsList = <dynamic>[
      tokenXAddress,
      tokenYAddress,
      poolFee,
      amountX,
      maxPriceVariation,
    ];
    print('paramsList: $paramsList');
    final thor_wallet.Wallet wallet =
        thor_wallet.Wallet(Get.find<WalletService>().getPrivateKey(password));
    final Map<dynamic, dynamic> res = await connector.transact(
      wallet,
      contract,
      'swapSingle',
      paramsList,
      swapManagerContract,
    );
    print(res);
    return '';
  }

  Future<List<BigInt>> getQuote({
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
    print('paramsList1: $paramsList');
    final Map<dynamic, dynamic> res = await connector.call(
      userAddress,
      contract,
      'quoteSingle',
      paramsList,
      quoterContract,
    );
    print(res);
    return <BigInt>[
      (res['decoded'] as Map<dynamic, dynamic>)[0] as BigInt,
      (res['decoded'] as Map<dynamic, dynamic>)[1] as BigInt,
    ];
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
    final Map<String, BigInt> newPriceMap = <String, BigInt>{};
    final Map<String, BigInt> oldPriceMap = <String, BigInt>{};
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
        oldPriceMap[pool.address!] = squrPriceX96;
        maxPriceVariation = multiplyBigintWithDouble(
          squrPriceX96,
          1 - (slippage.value / 100),
        );
        poolFee = pool.fee;

        final List<BigInt> quoteAndNewPrice = await getQuote(
          tokenXAddress: tokenX.value!.tokenAddress,
          tokenYAddress: tokenY.value!.tokenAddress,
          amountX: amountX.value,
          poolFee: pool.fee,
          maxPriceVariation: maxPriceVariation,
        );
        print('quote: $quoteAndNewPrice');
        quoteMap[pool.address!] = quoteAndNewPrice[0];
        newPriceMap[pool.address!] = quoteAndNewPrice[1];
      }
    } else {
      throw NoPoolFoundException('No pool found for the given token pair.');
    }
    print('quoteMap: $quoteMap');

    final MapEntry<String, BigInt> bestQuoteEntry = quoteMap.entries.reduce(
      (MapEntry<String, BigInt> entry1, MapEntry<String, BigInt> entry2) =>
          entry1.value < entry2.value ? entry1 : entry2,
    );

    final BigInt bestQuote = bestQuoteEntry.value;
    final String keyOfBestQuote = bestQuoteEntry.key;
    final double percentageDifference =
        ((newPriceMap[keyOfBestQuote]! - oldPriceMap[keyOfBestQuote]!) /
                oldPriceMap[keyOfBestQuote]!) *
            100;
    priceImpact.value = percentageDifference;
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
