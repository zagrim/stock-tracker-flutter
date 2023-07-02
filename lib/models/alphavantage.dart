import 'dart:ffi';

class AlphaVantageSearchResult {
  final String symbol;
  final String name;
  final String type;
  final String region;
  final String currency;

  const AlphaVantageSearchResult(
      {required this.symbol,
      required this.name,
      required this.type,
      required this.region,
      required this.currency});

  factory AlphaVantageSearchResult.fromJson(Map<String, dynamic> json) {
    return AlphaVantageSearchResult(
      symbol: json['1. symbol'],
      name: json['2. name'],
      type: json['3. type'],
      region: json['4. region'],
      currency: json['8. currency'],
    );
  }

  static List<AlphaVantageSearchResult> unwrapResult(
      Map<String, dynamic> json) {
    return (json['bestMatches'] as List)
        .map((match) => AlphaVantageSearchResult.fromJson(match))
        .toList();
  }
}
/*
    "bestMatches": [
        {
            "1. symbol": "FACEX",
            "2. name": "FROST GROWTH EQUITY FUND INVESTOR CLASS SHARES",
            "3. type": "Mutual Fund",
            "4. region": "United States",
            "5. marketOpen": "09:30",
            "6. marketClose": "16:00",
            "7. timezone": "UTC-04",
            "8. currency": "USD",
            "9. matchScore": "0.8889"
        }
    ]
*/

class AlphaVantageQuoteResult {
  final String symbol;
  final Float open;
  final Float high;
  final Float low;
  final Float price;
  final Float volume; // TODO: or Int?
  final String latestTradingDay;
  final Float previousClose;
  final Float change;
  final Float changePercent;

  const AlphaVantageQuoteResult(
      {required this.symbol,
      required this.open,
      required this.high,
      required this.low,
      required this.price,
      required this.volume,
      required this.latestTradingDay,
      required this.previousClose,
      required this.change,
      required this.changePercent});

  factory AlphaVantageQuoteResult.fromJson(Map<String, dynamic> json) {
    return AlphaVantageQuoteResult(
      symbol: json['01. symbol'],
      open: json['02. open'],
      high: json['03. high'],
      low: json['04. low'],
      price: json['05. price'],
      volume: json['06. volume'],
      latestTradingDay: json['07. latest trading day'],
      previousClose: json['08. previous close'],
      change: json['09. change'],
      changePercent: json['10. change percent'],
    );
  }

  static AlphaVantageQuoteResult unwrapResult(Map<String, dynamic> json) {
    return AlphaVantageQuoteResult.fromJson(json['Global Quote']);
  }
}
/*
    "Global Quote": {
        "01. symbol": "300135.SHZ",
        "02. open": "2.7100",
        "03. high": "2.7600",
        "04. low": "2.6400",
        "05. price": "2.7400",
        "06. volume": "7694000",
        "07. latest trading day": "2022-04-18",
        "08. previous close": "2.7300",
        "09. change": "0.0100",
        "10. change percent": "0.3663%"
    }
*/