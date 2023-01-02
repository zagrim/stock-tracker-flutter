class Stock {
  final String ticker;
  final String name;
  final String currency;
  final DateTime? timestamp;
  final double? latestPrice;
  /*final double highPrice;
  final double lowPrice;
  final double latestVolume;*/
  final double? dayChange;
  final double? dayChangePercent;

  Stock(
    this.ticker,
    this.name,
    this.currency,
    this.timestamp,
    this.latestPrice,
    this.dayChange,
    this.dayChangePercent,
  );
}
