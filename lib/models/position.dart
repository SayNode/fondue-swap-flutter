import 'pool_address_and_tokens.dart';

class Position {
  Position({
    required this.pool,
    required this.liquidity,
    required this.id,
    required this.maxPrice,
    required this.minPrice,
  });
  final PoolAddressAndTokens pool;
  final BigInt liquidity;
  final BigInt id;
  BigInt? tokenXProvided;
  BigInt? tokenYProvided;
  BigInt? tkxFee;
  BigInt? tkyFee;
  double maxPrice;
  double minPrice;
}
