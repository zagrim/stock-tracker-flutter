import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import './stock_list_item.dart';
import '../models/stock.dart';

class StockList extends StatelessWidget {
  const StockList({Key? key, required this.stockList}) : super(key: key);

  final List<Stock> stockList;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ListView.builder(
        itemBuilder: (ctx, index) {
          return Container(
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 8.0),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 16.0,
              ),
              child: StockListItem(stockList[index]),
            ),
          );
        },
        itemCount: stockList.length,
      ),
    );
  }
}
