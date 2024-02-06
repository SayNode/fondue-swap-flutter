class Token {
  Token(
    this.name,
    this.icon,
    this.tokenAddress,
    this.decimals,
  );

  Token.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String,
        icon = json['icon'] as String,
        tokenAddress = json['tokenAddress'] as String,
        decimals = json['decimals'] as int;

  final String name;

  final String icon;

  final String tokenAddress;

  final int decimals;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': name,
        'icon': icon,
        'tokenAddress': tokenAddress,
        'decimals': decimals,
      };
}
