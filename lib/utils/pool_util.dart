import 'dart:io';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:thor_request_dart/connect.dart';
import 'package:thor_request_dart/contract.dart';
import 'package:thor_request_dart/wallet.dart' as thor_wallet;
import 'package:web3dart/credentials.dart';

import '../models/pool.dart';
import '../services/swap_service/exceptions.dart';
import '../services/wallet_service.dart';
import 'globals.dart';

///Function to get all pools for a given token pair from the pool factory contract.
Future<List<Pool>> getCreatedPools({
  required String tokenX,
  required String tokenY,
}) async {
  final Connect connector = Connect(vechainNodeUrl);
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
  final Connect connector = Connect(vechainNodeUrl);
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
  return ((response['decoded'] as Map<dynamic, dynamic>)[0] as EthereumAddress)
      .hex;
}

Future<BigInt> getSqrtPriceX96(String contractAddress) async {
  final Connect connector = Connect(vechainNodeUrl);
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

double sqrtPriceX96ToNormalPrice(BigInt sqrtPriceX96) {
  return pow(sqrtPriceX96 / BigInt.from(2).pow(96), 2) as double;
}

//TODO: make it multiple of 60, 200 for the other fees
int getTick(double price) {
  final int tickPrecise = log(price) ~/ log(1.0001);
  return (tickPrecise ~/ 10) * 10;
}

Future<String> approveFunds({
  required BigInt amount,
  required String tokenAddress,
  required String password,
  required EthereumAddress spender,
}) async {
  final Connect connector = Connect(vechainNodeUrl);
  final String abi = await rootBundle.loadString('assets/abi/token_abi.json');
  final Contract contract = Contract.fromJsonString(abi);
  final List<dynamic> paramsList = <dynamic>[
    spender,
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
  return res['id'] as String;
}

///   Wait for tx receipt, for several seconds
///   Returns the receipt or Null
Future<Map<dynamic, dynamic>?> waitForTxReceipt(
  String txId, {
  int timeout = 20,
}) async {
  final Connect connector = Connect(vechainNodeUrl);
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
