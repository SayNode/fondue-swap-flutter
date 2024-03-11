import 'package:crypt/crypt.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'globals.dart';

Future<bool> checkPassword(String password) async {
  const FlutterSecureStorage storage = FlutterSecureStorage();
  final String? storedHashedPassword =
      await storage.read(key: encryptedMessage);
  if (storedHashedPassword == null) {
    return Future<bool>.value(false);
  }
  return Future<bool>.value(Crypt(storedHashedPassword).match(password));
}
