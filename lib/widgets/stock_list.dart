import 'package:flutter/material.dart';
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
          // TODO: Will there be issues when the list grows and non-visible widgets
          // get reused for different data? Should have separate (value) provider
          // for a single stock?
          return Container(
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 8.0),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 16.0,
              ),
              child: Dismissible(
                key: ValueKey(portfolio.stocks[index].ticker),
                direction: DismissDirection.endToStart,
                background: Container(
                  alignment: Alignment.centerRight,
                  color: Theme.of(context).errorColor,
                  child: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                  padding: const EdgeInsets.only(right: 20),
                ),
                child: StockListItem(portfolio.stocks[index]),
                onDismissed: (direction) {
                  portfolio.deleteStock(portfolio.stocks[index].ticker);
                },
              ),
            ),
          );
        },
        itemCount: portfolio.stocks.length,
      ),
    );
  }
}
