class Crypto {
  final String name;
  final String symbol;
  final double price;
  final double change24h;
  final double change7d;
  final double change30d;
  final double change1y;
  final double marketCap;

  Crypto({
    required this.name,
    required this.symbol,
    required this.price,
    required this.change24h,
    required this.change7d,
    required this.change30d,
    required this.change1y,
    required this.marketCap,
  });

  factory Crypto.fromJson(Map<String, dynamic> json) {
    return Crypto(
      name: json['name'],
      symbol: json['symbol'],
      price: json['price_usd'] != null ? double.parse(json['price_usd']) : 0.0,
      change24h: json['percent_change_24h'] != null
          ? double.parse(json['percent_change_24h'])
          : 0.0,
      change7d: json['percent_change_7d'] != null
          ? double.parse(json['percent_change_7d'])
          : 0.0,
      change30d: json['percent_change_30d'] != null
          ? double.parse(json['percent_change_30d'])
          : 0.0,
      change1y: json['percent_change_1y'] != null
          ? double.parse(json['percent_change_1y'])
          : 0.0,
      marketCap: json['market_cap_usd'] != null
          ? double.parse(json['market_cap_usd'])
          : 0.0,
    );
  }
}
