class Wallet {
  final String address;

  final Map keystore;

  Wallet(this.address, this.keystore);

  static Wallet fromJson(Map<String, dynamic> json) => Wallet(
        json['address'] as String,
        json['keystore'] as Map,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'address': address,
        'keystore': keystore,
      };
}
