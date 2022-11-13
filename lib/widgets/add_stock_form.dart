import 'package:flutter/material.dart';
import 'package:stock_tracker/models/stock.dart';

import '../models/alphavantage.dart';
import '../services/alphavantage_api.dart';

class AddStockForm extends StatefulWidget {
  const AddStockForm(this.onAddStock, {Key? key}) : super(key: key);

  final Function onAddStock;

  @override
  State<AddStockForm> createState() => _AddStockFormState();
}

class _AddStockFormState extends State<AddStockForm> {
  final stockSearchController = TextEditingController();
  final List<AlphaVantageSearchResult> searchResults = [];

  @override
  Widget build(BuildContext context) {
    return Card(child: LayoutBuilder(builder: (context, constraints) {
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
          /*Column(
              children: searchResults
                  .map((item) => Card(
                        child: Column(
                          children: [
                            Text(item.symbol),
                            Text(item.name),
                          ],
                        ),
                      ))
                  .toList(),
            ),*/
          SizedBox(
            height: constraints.maxHeight -
                55, //min(200, constraints.maxHeight - 55),
            // TODO: preferably textfield height instead of magic const 55
            child: ListView.builder(
              itemBuilder: (ctx, index) {
                print(searchResults[index].symbol);
                return StockSearchResult(
                  searchResult: searchResults[index],
                  onClick: () => _addStockToList(
                    _transformToStock(searchResults[index]),
                  ),
                );
              },
              itemCount: searchResults.length,
            ),
          ),
          /*TextButton(
              onPressed: () => _submit(_closeModal),
              child: const Text('Add'),
            )*/
        ],
      );
    }));
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

  void _addStockToList(Stock stockToAdd) {
    print('submit');
    print(stockToAdd);
    widget.onAddStock(stockToAdd);
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
        child: Container(
          child: Card(
            child: Column(
              children: [
                Text(searchResult.symbol),
                Text(searchResult.name),
              ],
            ),
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 16.0,
          ),
        ),
      ),
    );
  }
}
