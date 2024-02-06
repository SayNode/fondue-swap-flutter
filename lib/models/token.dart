class Token {
  Token(
    this.name,
    this.abbreviation,
    this.icon,
    this.tokenAddress,
    this.decimals,
  );

  Token.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String,
        abbreviation = json['abbreviation'] as String,
        icon = json['icon'] as String,
        tokenAddress = json['tokenAddress'] as String,
        decimals = json['decimals'] as int;

  final String name;

  final String abbreviation;

  final String icon;

  final String tokenAddress;

  final int decimals;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': name,
        'abbreviation': abbreviation,
        'icon': icon,
        'tokenAddress': tokenAddress,
        'decimals': decimals,
      };
}
