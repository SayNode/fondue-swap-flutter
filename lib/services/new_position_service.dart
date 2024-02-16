import 'package:get/get.dart';
import 'package:thor_request_dart/connect.dart';

import '../models/token.dart';
import '../utils/globals.dart';

class NewPositionService extends GetxService {
  Connect connector = Connect(vechainNodeUrl);

  RxDouble fee = 0.0.obs;

  Rx<Token?> tokenX = Rxn<Token>();
  Rx<Token?> tokenY = Rxn<Token>();
}
