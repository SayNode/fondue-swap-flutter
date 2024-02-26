import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:thor_request_dart/connect.dart';
import 'package:thor_request_dart/contract.dart';
import 'package:thor_request_dart/wallet.dart' as thor_wallet;

import '../models/pool_address_and_tokens.dart';
import '../models/position.dart';
import '../models/token.dart';
import '../utils/exceptions.dart';
import '../utils/globals.dart';
import '../utils/pool_util.dart';
import 'token_service.dart';
import 'wallet_service.dart';

class PositionService extends GetxService {
  Connect connector = Connect(vechainNodeUrl);

  RxList<Position> positionList = <Position>[].obs;

  final List<PoolAddressAndTokens> poolAddressAndTokensList =
      <PoolAddressAndTokens>[];

  Future<void> fetchPositions() async {
    try {
      final String abi =
          await rootBundle.loadString('assets/abi/pool_nft_abi.json');
      final Contract contract = Contract.fromJsonString(abi);
      final String userAddress =
          Get.find<WalletService>().wallet.value!.address;
      final Map<dynamic, dynamic> response = await connector.call(
        userAddress,
        contract,
        'userToAllPositionsOne',
        <dynamic>[userAddress],
        nftContractAddress,
      );
      final Map<dynamic, dynamic> decoded =
          response['decoded'] as Map<dynamic, dynamic>;
      if (response['reverted']) {
        throw ContractCallRevertedException(decoded.toString());
      }
      final List<Position> allPositionsList = <Position>[];

      for (int i = 0; i < (decoded[0] as List<dynamic>).length; i++) {
        PoolAddressAndTokens poolAddressAndTokens;
        try {
          poolAddressAndTokens = poolAddressAndTokensList.firstWhere(
            (PoolAddressAndTokens element) =>
                element.poolAddress == (decoded[1] as List<dynamic>)[i],
          );
        } catch (e) {
          poolAddressAndTokens = await createPoolFromPoolAddress(
            poolAddress: (decoded[1] as List<dynamic>)[i].toString(),
          );
          poolAddressAndTokensList.add(poolAddressAndTokens);
        }
        final Position position = Position(
          pool: poolAddressAndTokens,
          liquidity: (decoded[2] as List<dynamic>)[i],
          id: (decoded[0] as List<dynamic>)[i],
          maxPrice: getTickPrice(
            ((decoded[4] as List<dynamic>)[i] as BigInt).toInt(),
          ),
          minPrice: getTickPrice(
            ((decoded[3] as List<dynamic>)[i] as BigInt).toInt(),
          ),
        );
        allPositionsList.add(position);
      }
      final List<Position> allPositionsWithAdditionalData =
          await fetchAditionalPositionsData(allPositionsList);
      final List<Position> allPositionsWithFeeData =
          await fetchPositionsFeeData(allPositionsWithAdditionalData);
      positionList.value = allPositionsWithFeeData;
    } catch (_) {}
  }

  Future<List<Position>> fetchAditionalPositionsData(
    List<Position> allPositionsList,
  ) async {
    final String abi =
        await rootBundle.loadString('assets/abi/pool_nft_abi.json');
    final Contract contract = Contract.fromJsonString(abi);
    final String userAddress = Get.find<WalletService>().wallet.value!.address;
    final Map<dynamic, dynamic> response = await connector.call(
      userAddress,
      contract,
      'userToAllPositionsTwo',
      <dynamic>[userAddress],
      nftContractAddress,
    );
    final Map<dynamic, dynamic> decoded =
        response['decoded'] as Map<dynamic, dynamic>;
    if (response['reverted']) {
      throw ContractCallRevertedException(decoded.toString());
    }
    for (int i = 0; i < (decoded[0] as List<dynamic>).length; i++) {
      final Position position = allPositionsList.firstWhere(
        (Position element) => element.id == (decoded[0] as List<dynamic>)[i],
      );
      allPositionsList[allPositionsList.indexOf(position)].tokenXProvided =
          (decoded[1] as List<dynamic>)[i];
      allPositionsList[allPositionsList.indexOf(position)].tokenYProvided =
          (decoded[2] as List<dynamic>)[i];
    }
    return allPositionsList;
  }

  Future<List<Position>> fetchPositionsFeeData(
    List<Position> allPositionsList,
  ) async {
    final String abi =
        await rootBundle.loadString('assets/abi/pool_nft_abi.json');
    final Contract contract = Contract.fromJsonString(abi);
    final String userAddress = Get.find<WalletService>().wallet.value!.address;
    final Map<dynamic, dynamic> response = await connector.call(
      userAddress,
      contract,
      'userToAllPositionsFees',
      <dynamic>[userAddress],
      nftContractAddress,
    );
    final Map<dynamic, dynamic> decoded =
        response['decoded'] as Map<dynamic, dynamic>;
    if (response['reverted']) {
      throw ContractCallRevertedException(decoded.toString());
    }
    for (int i = 0; i < (decoded[0] as List<dynamic>).length; i++) {
      final Position position = allPositionsList.firstWhere(
        (Position element) => element.id == (decoded[0] as List<dynamic>)[i],
      );
      allPositionsList[allPositionsList.indexOf(position)].tkxFee =
          (decoded[1] as List<dynamic>)[i];
      allPositionsList[allPositionsList.indexOf(position)].tkyFee =
          (decoded[2] as List<dynamic>)[i];
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
    final Token token1 = tokenList
        .firstWhere((Token token) => token.tokenAddress == token1Address);

    final double currentPrice = await getCurrentPrice(poolAddress);

    return PoolAddressAndTokens(
      poolAddress: poolAddress,
      token0: token0,
      token1: token1,
      currentPrice: currentPrice,
    );
  }

  Future<String> collect(
    String password,
    BigInt positionId, {
    bool onlyFees = false,
  }) async {
    BigInt liquidity = BigInt.zero;
    if (!onlyFees) {
      liquidity = await getLiquidity(positionId);
    }
    final String abi =
        await rootBundle.loadString('assets/abi/pool_nft_abi.json');
    final Contract contract = Contract.fromJsonString(abi);
    final thor_wallet.Wallet wallet =
        thor_wallet.Wallet(Get.find<WalletService>().getPrivateKey(password));

    final Map<dynamic, dynamic> response = await connector.transact(
      wallet,
      contract,
      'removeLiquidity',
      <dynamic>[
        positionId,
        liquidity,
      ],
      nftContractAddress,
    );

    final String txId = response['id'] as String;

    await waitForTxReceipt(txId);

    final Map<dynamic, dynamic> responseCollect = await connector.transact(
      wallet,
      contract,
      'collect',
      <dynamic>[
        positionId,
      ],
      nftContractAddress,
    );
    return responseCollect['id'] as String;
  }

  Future<String> burnPosition(String password, BigInt positionId) async {
    final String abi =
        await rootBundle.loadString('assets/abi/pool_nft_abi.json');
    final Contract contract = Contract.fromJsonString(abi);
    final thor_wallet.Wallet wallet =
        thor_wallet.Wallet(Get.find<WalletService>().getPrivateKey(password));

    final Map<dynamic, dynamic> response = await connector.transact(
      wallet,
      contract,
      'burn',
      <dynamic>[
        positionId,
      ],
      nftContractAddress,
    );

    final String txId = response['id'] as String;
    return txId;
  }

  Future<BigInt> getLiquidity(BigInt positionId) async {
    final String abi =
        await rootBundle.loadString('assets/abi/pool_nft_abi.json');
    final Contract contract = Contract.fromJsonString(abi);
    final String userAddress = Get.find<WalletService>().wallet.value!.address;
    final Map<dynamic, dynamic> response = await connector.call(
      userAddress,
      contract,
      'tokenIDtoPosition',
      <dynamic>[positionId],
      nftContractAddress,
    );
    final Map<dynamic, dynamic> decoded =
        response['decoded'] as Map<dynamic, dynamic>;
    if (response['reverted']) {
      throw ContractCallRevertedException(decoded.toString());
    }
    return decoded[1] as BigInt;
  }
}
