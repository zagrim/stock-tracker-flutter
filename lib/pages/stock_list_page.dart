import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/stock_portfolio.dart';
import '../widgets/main_drawer.dart';
import '../widgets/stock_list.dart';
import '../widgets/add_stock_form.dart';
import '../models/stock.dart';

class StockListPage extends StatelessWidget {
  static const routeName = '/stock-list';

  const StockListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final portfolio = context.watch<StockPortfolio>();
    void _onAddStock(Stock stock) {
      // TODO: fetch data for the added stock
      portfolio.addStock(stock);
      Navigator.of(context).pop();
    }

    final _appBar = AppBar(
      title: const Text('Stocks'),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.of(context).pushNamed(AddStockForm.routeName,
                arguments: {'onAddStock': _onAddStock});
          },
          icon: const Icon(Icons.add),
        ),
      ],
    );
    final _appBarHeight = _appBar.preferredSize.height;
    final _mediaQuery = MediaQuery.of(context);
    final _contentMaxHeight =
        _mediaQuery.size.height - _appBarHeight - _mediaQuery.padding.vertical;

    return SafeArea(
      child: Scaffold(
        appBar: _appBar,
        drawer: const MainDrawer(),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                height: _contentMaxHeight,
                child: StockList(),
              ),
              /*LayoutBuilder(builder: (context, constraints) {
                    return SizedBox(
                      height: constraints.maxHeight,
                      child: StockList(stockList: _stocks),
                    );
                  })*/
              /* BoxConstraints forces an infinite height.
                  These invalid constraints were provided to RenderConstrainedBox's layout() function by the following function, which probably computed the invalid constraints in question:
                  RenderConstrainedBox.performLayout*/
            ],
          ),
        ),
      ),
    );
  }
}
