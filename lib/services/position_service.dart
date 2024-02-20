import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:thor_request_dart/connect.dart';
import 'package:thor_request_dart/contract.dart';

import '../models/pool_address_and_tokens.dart';
import '../models/position.dart';
import '../models/token.dart';
import '../utils/exceptions.dart';
import '../utils/globals.dart';
import 'token_service.dart';
import 'wallet_service.dart';

class PositionService extends GetxService {
  Connect connector = Connect(vechainNodeUrl);

  RxList<Position> positionList = <Position>[].obs;

  Future<List<Position>> fetchPositions() async {
    final String abi =
        await rootBundle.loadString('assets/abi/pool_nft_abi.json');
    final Contract contract = Contract.fromJsonString(abi);
    final String userAddress = Get.find<WalletService>().wallet.value!.address;
    final Map<dynamic, dynamic> response = await connector.call(
      userAddress,
      contract,
      'userToAllPositions',
      <dynamic>[userAddress],
      nftContractAddress,
    );
    final Map<dynamic, dynamic> decoded =
        response['decoded'] as Map<dynamic, dynamic>;
    if (response['reverted']) {
      throw ContractCallRevertedException(decoded.toString());
    }
    final List<Position> allPositionsList = <Position>[];
    final List<PoolAddressAndTokens> poolAddressAndTokensList =
        <PoolAddressAndTokens>[];
    for (int i = 0; i < (decoded[0] as List<dynamic>).length; i++) {
      PoolAddressAndTokens poolAddressAndTokens;
      try {
        poolAddressAndTokens = poolAddressAndTokensList.firstWhere(
          (PoolAddressAndTokens element) =>
              element.poolAddress == (decoded[0] as List<dynamic>)[i],
        );
      } catch (e) {
        poolAddressAndTokens = await createPoolFromPoolAddress(
          poolAddress: (decoded[0] as List<dynamic>)[i].toString(),
        );
        poolAddressAndTokensList.add(poolAddressAndTokens);
      }
      final Position position = Position(
        pool: poolAddressAndTokens,
        liquidity: (decoded[1] as List<dynamic>)[i],
        id: i,
      );
      allPositionsList.add(position);
    }
    return allPositionsList;
  }

  Future<PoolAddressAndTokens> createPoolFromPoolAddress({
    required String poolAddress,
  }) async {
    final String abi = await rootBundle.loadString('assets/abi/pool_abi.json');
    final Contract contract = Contract.fromJsonString(abi);
    final Map<dynamic, dynamic> responseToken0 = await connector.call(
      poolAddress,
      contract,
      'token0',
      <dynamic>[],
      poolAddress,
    );
    final Map<dynamic, dynamic> decoded =
        responseToken0['decoded'] as Map<dynamic, dynamic>;
    if (responseToken0['reverted']) {
      throw ContractCallRevertedException(decoded.toString());
    }
    final Map<dynamic, dynamic> responseToken1 = await connector.call(
      poolAddress,
      contract,
      'token1',
      <dynamic>[],
      poolAddress,
    );
    final Map<dynamic, dynamic> decodedToken1 =
        responseToken1['decoded'] as Map<dynamic, dynamic>;
    if (responseToken1['reverted']) {
      throw ContractCallRevertedException(decodedToken1.toString());
    }
    final List<Token> tokenList = Get.find<TokenService>().tokensList;
    final String token0Address = decoded[0].toString();
    final String token1Address = decodedToken1[0].toString();
    final Token token0 = tokenList
        .firstWhere((Token token) => token.tokenAddress == token0Address);
    tokenList.add(
      token0,
    );
    final Token token1 = tokenList
        .firstWhere((Token token) => token.tokenAddress == token1Address);

    return PoolAddressAndTokens(
      poolAddress: poolAddress,
      token0: token0,
      token1: token1,
    );
  }

  Future<void> removePosition({
    required String password,
    required int id,
  }) async {
    // remove position
  }

  Future<void> collectFees({
    required String password,
    required int id,
  }) async {
    // collect fees
  }
}
