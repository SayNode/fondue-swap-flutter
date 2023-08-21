import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:thor_devkit_dart/crypto/address.dart';
import 'package:thor_devkit_dart/crypto/hd_node.dart';
import 'package:thor_devkit_dart/crypto/keystore.dart';
import 'package:thor_devkit_dart/crypto/secp256k1.dart';

import '../models/wallet.dart';

class WalletService extends GetxService {
  Rx<Wallet?> wallet = Rx<Wallet?>(null);

  Future<void> init() async {
    super.onInit();
    await loadWallet();
  }

  Future<void> importWalletWithSeed(String password, String seedPhrase) async {
    var priv = HDNode.fromMnemonic(seedPhrase.toLowerCase().split(' ')).privateKey;
    var address = Address.publicKeyToAddressString(derivePublicKeyFromBytes(priv!, false));
    var keystore = Keystore.encrypt(priv, password);
    wallet.value = Wallet(address, json.decode(keystore));
    await saveWallet(wallet.value!);
  }

  saveWallet(Wallet wallet) async {
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
