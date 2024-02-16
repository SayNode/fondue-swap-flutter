class Pool {
  Pool({
    required this.tokenX,
    required this.tokenY,
    required this.fee,
  });
  final String tokenX;
  final String tokenY;
  final BigInt fee;
  String? address;
  BigInt? price;
}
