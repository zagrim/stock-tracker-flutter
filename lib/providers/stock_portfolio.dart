import 'dart:collection';

import 'package:flutter/foundation.dart';

import '../models/stock.dart';

class StockPortfolio with ChangeNotifier {
  List<Stock> _stocks = [
    Stock('QTCOM', 'Qt Group Oyj', 'EUR', DateTime.now(), 135.60, -1, -0.008),
    Stock('MUSTI', 'Musti Group Oyj', 'EUR', DateTime.now(), 30.43, 1, 0.0032),
    Stock('A', 'A', 'EUR', DateTime.now(), 30.43, 1, 0.0032),
    Stock('B', 'B', 'EUR', DateTime.now(), 30.43, 1, 0.0032),
    Stock('C', 'C', 'EUR', DateTime.now(), 30.43, 1, 0.0032),
    Stock('D', 'D', 'EUR', DateTime.now(), 30.43, 1, 0.0032),
    Stock('E', 'E', 'EUR', DateTime.now(), 30.43, 1, 0.0032),
    Stock('F', 'F', 'EUR', DateTime.now(), 30.43, 1, 0.0032),
    Stock('G', 'G', 'EUR', DateTime.now(), 30.43, 1, 0.0032),
    Stock('H', 'H', 'EUR', DateTime.now(), 30.43, 1, 0.0032),
    Stock('I', 'I', 'EUR', DateTime.now(), 30.43, 1, 0.0032),
    Stock('J', 'J', 'EUR', DateTime.now(), 30.43, 1, 0.0032),
    Stock('K', 'K', 'EUR', DateTime.now(), 30.43, 1, 0.0032),
    Stock('L', 'L', 'EUR', DateTime.now(), 30.43, 1, 0.0032),
    Stock('M', 'M', 'EUR', DateTime.now(), 30.43, 1, 0.0032),
    Stock('N', 'N', 'EUR', DateTime.now(), 30.43, 1, 0.0032),
    Stock('O', 'O', 'EUR', DateTime.now(), 30.43, 1, 0.0032),
    Stock('P', 'P', 'EUR', DateTime.now(), 30.43, 1, 0.0032),
    Stock('Q', 'Q', 'EUR', DateTime.now(), 30.43, 1, 0.0032),
    Stock('R', 'R', 'EUR', DateTime.now(), 30.43, 1, 0.0032),
  ];

  UnmodifiableListView<Stock> get stocks => UnmodifiableListView(_stocks);

  addStock(Stock stock) {
    _stocks.add(stock);
    print('added stock ' + stock.ticker);
    notifyListeners();
  }

  deleteStock(String ticker) {
    _stocks.removeWhere((s) => s.ticker == ticker);
    print('removed stock ' + ticker);
    notifyListeners();
  }
}
