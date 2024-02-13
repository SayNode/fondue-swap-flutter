import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/pool.dart';
import '../../services/swap_service/swap_service.dart';

class PotsPage extends StatelessWidget {
  const PotsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final SwapService swapService = Get.find<SwapService>();
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Text(
            'Pots',
            style: TextStyle(color: Colors.red),
          ),
          ElevatedButton(
            onPressed: () async {
              await swapService.getQuote(
                tokenXAddress: '0xc3c179ad9633e5c968119b203a87e9ecf37c80b0',
                tokenYAddress: '0x08ce97aee8d61ca23ea1f328be98117555cdca50',
                amountX: BigInt.from(1000),
                poolFee: 500,
                maxPriceVariation:
                    BigInt.parse('5602277097478613991869082763264'),
              );
            },
            child: const Text('debug'),
          ),
          ElevatedButton(
            onPressed: () async {
              final List<Pool> pools = await swapService.getCreatedPools(
                tokenX: '0xc3c179ad9633e5c968119b203a87e9ecf37c80b0',
                tokenY: '0x08ce97aee8d61ca23ea1f328be98117555cdca50',
              );

              final String address =
                  await swapService.getPoolAddress(pool: pools[0]);
              print(address);
            },
            child: const Text('debug'),
          ),
        ],
      ),
    );
  }
}
