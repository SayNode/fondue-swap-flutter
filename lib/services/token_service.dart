import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart' as root_bundle;
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:thor_request_dart/connect.dart';
import 'package:thor_request_dart/contract.dart';

import '../models/token.dart';
import '../utils/globals.dart';
import 'wallet_service.dart';

class TokenService extends GetxService {
  late List<Token> _tokenList;

  List<Token> get tokensList => _tokenList;

  Future<bool> init() async {
    if (devMode) {
      _tokenList = await _loadTokensDevMode();
    } else {
      _tokenList = await _loadTokenList();
    }
    unawaited(getBalances());
    return true;
  }

  Future<List<Token>> _loadTokenList() async {
    //TODO: Implement fetching token list vechain token registry
    return <Token>[];
  }

  Future<List<Token>> _loadTokensDevMode() async {
    final String jsondata =
        await root_bundle.rootBundle.loadString('assets/data/token.json');
    final List<Map<String, dynamic>> list =
        (json.decode(jsondata) as List<dynamic>).cast<Map<String, dynamic>>();
    final List<Token> token = list.map(Token.fromJson).toList();
    return token;
  }

  Future<void> getBalances() async {
    String userAddress = '';
    try {
      userAddress = Get.find<WalletService>().wallet.value!.address;
    } catch (_) {}
    if (userAddress.isNotEmpty) {
      final Connect connect = Connect(vechainNodeUrl);
      final String abi =
          await rootBundle.loadString('assets/abi/token_abi.json');
      final Contract contract = Contract.fromJsonString(abi);
      for (final Token token in _tokenList) {
        final Map<dynamic, dynamic> response = await connect.call(
          token.tokenAddress,
          contract,
          'balanceOf',
          <dynamic>[userAddress],
          token.tokenAddress,
        );
        final BigInt balance =
            (response['decoded'] as Map<dynamic, dynamic>)[0] as BigInt;
        token.balance.value = balance;
      }
    }
  }
}
