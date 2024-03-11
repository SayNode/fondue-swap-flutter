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
    final Uint8List? priv =
        HDNode.fromMnemonic(seedPhrase.toLowerCase().split(' ')).privateKey;
    final String address = Address.publicKeyToAddressString(
      derivePublicKeyFromBytes(priv!, false),
    );
    final String keystore = Keystore.encrypt(priv, password);
    final Wallet wallet =
        Wallet(address, json.decode(keystore) as Map<String, dynamic>);
    await saveWallet(wallet);
    this.wallet.value = wallet;
  }

  Future<bool> importWalletWithPrivateKey(
    String password,
    String privateKey,
  ) async {
    try {
      final Uint8List priv = hexToBytes(privateKey);
      final String address = Address.publicKeyToAddressString(
        derivePublicKeyFromBytes(priv, false),
      );
      final String keystore = Keystore.encrypt(priv, password);
      final Wallet wallet =
          Wallet(address, json.decode(keystore) as Map<String, dynamic>);
      await saveWallet(wallet);
      this.wallet.value = wallet;
      return true;
    } catch (_) {
      return false;
    }
  }

  Uint8List getPrivateKey(String password) {
    final Wallet wallet = Get.find<WalletService>().wallet.value!;
    final Uint8List priv =
        Keystore.decrypt(json.encode(wallet.keystore), password);
    final String address =
        Address.publicKeyToAddressString(derivePublicKeyFromBytes(priv, false));
    if (address.toLowerCase() != wallet.address.toLowerCase()) {
      throw Exception('Private key does not match wallet address');
    }
    return priv;
  }

  Future<void> saveWallet(Wallet wallet) async {
    const FlutterSecureStorage storage = FlutterSecureStorage();
    await storage.write(key: 'wallet', value: json.encode(wallet.toJson()));
  }

  Future<void> loadWallet() async {
    const FlutterSecureStorage storage = FlutterSecureStorage();
    final String? jsondata = await storage.read(key: 'wallet');
    if (jsondata != null) {
      wallet.value =
          Wallet.fromJson(json.decode(jsondata) as Map<String, dynamic>);
    }
  }
}
