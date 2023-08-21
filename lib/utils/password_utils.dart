import 'package:crypt/crypt.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'globals.dart';

Future<bool> checkPassword(String password) async {
  FlutterSecureStorage storage = const FlutterSecureStorage();
  String? storedHashedPassword = await storage.read(key: encryptedMessage);
  if (storedHashedPassword == null) {
    return Future.value(false);
  }
  return Future.value(Crypt(storedHashedPassword).match(password));
}
