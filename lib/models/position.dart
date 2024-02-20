import 'pool_address_and_tokens.dart';

class Position {
  Position({
    required this.pool,
    required this.liquidity,
    required this.id,
  });
  final PoolAddressAndTokens pool;
  final BigInt liquidity;
  final int id;
}
