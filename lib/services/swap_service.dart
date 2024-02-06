import 'package:get/get.dart';

import '../models/token.dart';

class SwapService extends GetxService {
  Rx<Token?> tokenX = Rxn<Token>();
  Rx<Token?> tokenY = Rxn<Token>();
}
