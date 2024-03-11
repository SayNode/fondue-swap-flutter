import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../services/token_service.dart';
import 'token_tile.dart';

class TokenListWidget extends StatelessWidget {
  const TokenListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final TokenService tokenService = Get.find<TokenService>();
    return Column(
      children: List<Widget>.generate(
        tokenService.tokensList.length,
        (int index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: TokenListTile(
            token: tokenService.tokensList[index],
          ),
        ),
      ),
    );
  }
}
