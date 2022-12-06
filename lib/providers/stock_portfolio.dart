import 'dart:collection';

import 'package:flutter/foundation.dart';

import '../models/stock.dart';

class StockPortfolio with ChangeNotifier {
  List<Stock> _stocks = [
    Stock('QTCOM', 'Qt Group Oyj', 'EUR', DateTime.now(), 135.60, -0.008),
    Stock('MUSTI', 'Musti Group Oyj', 'EUR', DateTime.now(), 30.43, 0.0032),
  ];

  UnmodifiableListView<Stock> get stocks => UnmodifiableListView(_stocks);

  addStock(Stock stock) {
    _stocks.add(stock);
    print('added stock ' + stock.ticker);
    notifyListeners();
  }

  deleteStock(Stock stock) {
    _stocks.removeWhere((s) => s.ticker == stock.ticker);
    print('removed stock ' + stock.ticker);
    notifyListeners();
  }
}
