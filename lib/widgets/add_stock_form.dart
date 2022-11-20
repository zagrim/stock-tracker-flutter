import 'package:flutter/material.dart';
import 'package:stock_tracker/models/stock.dart';

import '../models/alphavantage.dart';
import '../services/alphavantage_api.dart';

class AddStockForm extends StatefulWidget {
  static const routeName = '/add-stock';

  const AddStockForm({Key? key}) : super(key: key);

  @override
  State<AddStockForm> createState() => _AddStockFormState();
}

class _AddStockFormState extends State<AddStockForm> {
  final stockSearchController = TextEditingController();
  final List<AlphaVantageSearchResult> searchResults = [];

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, Object>;
    final Function _onAddStock = routeArgs['onAddStock'] as Function;

    return Scaffold(
      appBar: AppBar(title: const Text("Add stock")),
      body: Card(child: LayoutBuilder(builder: (context, constraints) {
        return Column(
          children: [
            TextField(
              autofocus: true,
              decoration: const InputDecoration(
                labelText: 'Ticker or name of stock to add',
              ),
              controller: stockSearchController,
              onSubmitted: (_) => _search(),
            ),
            SizedBox(
              height: constraints.maxHeight -
                  55, //min(200, constraints.maxHeight - 55),
              // TODO: preferably textfield height instead of magic const 55
              child: ListView.builder(
                itemBuilder: (ctx, index) {
                  print(searchResults[index].symbol);
                  return StockSearchResult(
                    searchResult: searchResults[index],
                    onClick: () => _onAddStock(
                      _transformToStock(searchResults[index]),
                    ),
                  );
                },
                itemCount: searchResults.length,
              ),
            ),
          ],
        );
      })),
    );
  }

  void _search() {
    searchForSymbol(stockSearchController.text).then((value) {
      setState(() {
        searchResults.clear();
        searchResults.addAll(value);
      });
    });
  }

  Stock _transformToStock(AlphaVantageSearchResult searchResult) {
    return Stock(
      searchResult.symbol,
      searchResult.name,
      searchResult.currency,
      null,
      null,
      null,
    );
  }
}

class StockSearchResult extends StatelessWidget {
  const StockSearchResult({
    Key? key,
    required this.searchResult,
    this.onClick,
  }) : super(key: key);

  final AlphaVantageSearchResult searchResult;
  final Function? onClick;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: InkWell(
        onTap: onClick != null ? () => onClick!() : () {},
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 16.0,
          ),
          child: Card(
            child: Column(
              children: [
                Text(searchResult.symbol),
                Text(searchResult.name),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
