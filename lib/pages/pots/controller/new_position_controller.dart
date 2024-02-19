import 'package:get/get.dart';

import '../../../models/pool.dart';
import '../../../services/new_position_service.dart';
import '../../../utils/pool_util.dart';
import '../../../utils/util.dart';

class NewPositionController extends GetxController {
  final NewPositionService newPositionService = Get.find<NewPositionService>();

  @override
  void onInit() {
    newPositionService.tokenX.listen((_) async {
      print('tokenX: ${newPositionService.tokenX.value}');
      await updatePool();
    });
    newPositionService.tokenY.listen((_) async {
      print('tokenY: ${newPositionService.tokenY.value}');
      await updatePool();
    });
    newPositionService.fee.listen((_) async {
      print('fee: ${newPositionService.fee.value}');
      await updatePool();
    });
    super.onInit();
  }

  void getAbsoluteMaxAndMin() {
    final double normalPrice =
        sqrtPriceX96ToNormalPrice(newPositionService.pool.value!.price!);
    newPositionService.sliderMax.value = (normalPrice * 10).floor().toDouble();
    newPositionService.sliderMin.value = (normalPrice / 10).floor().toDouble();
    print('Max: ${newPositionService.sliderMax.value}');
    print('Min: ${newPositionService.sliderMin.value}');
    print('normal price: $normalPrice');
    print('magnitude of normal price: ${orderOfMagnitude(normalPrice)}');
  }

  Future<void> updatePool() async {
    //If tokenX, tokenY and fee are selected, get the pool
    if (newPositionService.tokenX.value != null &&
        newPositionService.tokenY.value != null &&
        newPositionService.fee.value != 0.0) {
      print('Fetching pool data');
      newPositionService.fetchingPoolData.value = true;
      final List<Pool> poolListForTokenPair = await getCreatedPools(
        tokenX: newPositionService.tokenX.value!.tokenAddress,
        tokenY: newPositionService.tokenY.value!.tokenAddress,
      );

      if (poolListForTokenPair.isNotEmpty) {
        newPositionService.pool.value = (poolListForTokenPair
              ..where(
                (Pool pool) =>
                    pool.fee / BigInt.from(10000) ==
                    newPositionService.fee.value,
              ))
            .first;

        print('Pool found for the given token pair');
        final String poolAddress =
            await getPoolAddress(pool: newPositionService.pool.value!);
        newPositionService.pool.value!.address = poolAddress;
        newPositionService.pool.value!.price =
            await getSqrtPriceX96(newPositionService.pool.value!.address!);
        print('Price: ${newPositionService.pool.value!.price}');
        getAbsoluteMaxAndMin();
      } else {
        print('No pool found for the given token pair');
      }
    }
    newPositionService.fetchingPoolData.value = false;
  }
}
