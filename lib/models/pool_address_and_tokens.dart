import 'token.dart';

class PoolAddressAndTokens {
  PoolAddressAndTokens({
    required this.poolAddress,
    required this.token0,
    required this.token1,
  });
  final String poolAddress;
  final Token token0;
  final Token token1;
}
