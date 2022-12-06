import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../providers/stock_portfolio.dart';
import './stock_list_item.dart';

class StockList extends StatelessWidget {
  const StockList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final portfolio = context.watch<StockPortfolio>();
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
              child: StockListItem(portfolio.stocks[index]),
            ),
          );
        },
        itemCount: portfolio.stocks.length,
      ),
    );
  }
}
