import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:thor_devkit_dart/crypto/address.dart';
import 'package:thor_devkit_dart/crypto/hd_node.dart';
import 'package:thor_devkit_dart/crypto/keystore.dart';
import 'package:thor_devkit_dart/crypto/secp256k1.dart';
import 'package:thor_devkit_dart/utils.dart';

import '../models/wallet.dart';

class WalletService extends GetxService {
  Rx<Wallet?> wallet = Rx<Wallet?>(null);

  Future<void> init() async {
    super.onInit();
    await loadWallet();
  }

  Future<void> importWalletWithSeed(String password, String seedPhrase) async {
    await compute(_deriveFromSeed, [password, seedPhrase]);
    saveWallet(wallet.value!);
  }

  Future<bool> importWalletWithPrivateKey(
      String password, String privateKey) async {
    try {
      var wallet = await compute(_deriveFromPrivateKey, [password, privateKey]);
      saveWallet(wallet);
      return true;
    } catch (e) {
      return false;
    }
  }

  _deriveFromPrivateKey(List params) {
    var priv = hexToBytes(params[1]);
    var address =
        Address.publicKeyToAddressString(derivePublicKeyFromBytes(priv, false));
    var keystore = Keystore.encrypt(priv, params[0]);
    return Wallet(address, json.decode(keystore));
  }

  _deriveFromSeed(List params) {
    var priv =
        HDNode.fromMnemonic(params[1].toLowerCase().split(' ')).privateKey;
    var address = Address.publicKeyToAddressString(
        derivePublicKeyFromBytes(priv!, false));
    var keystore = Keystore.encrypt(priv, params[0]);
    return Wallet(address, json.decode(keystore));
  }

  saveWallet(Wallet wallet) async {
    print('address: ${wallet.address}');
    FlutterSecureStorage storage = const FlutterSecureStorage();
    storage.write(key: 'wallet', value: json.encode(wallet.toJson()));
  }

  loadWallet() async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    final jsondata = await storage.read(key: 'wallet');
    if (jsondata != null) {
      wallet.value = Wallet.fromJson(json.decode(jsondata));
    }
  }
}
