import 'dart:convert';

import 'package:flutter/services.dart' as root_bundle;
import 'package:get/get.dart';

import '../models/token.dart';
import '../utils/globals.dart';

class TokenService extends GetxService {
  late List<Token> _tokenList;

  List<Token> get tokensList => _tokenList;

  Future<bool> init() async {
    if (devMode) {
      _tokenList = await _loadTokensDevMode();
    } else {
      _tokenList = await _loadTokenList();
    }
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
}
