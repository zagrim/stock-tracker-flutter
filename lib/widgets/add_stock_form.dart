import 'package:flutter/material.dart';

import '../models/stock.dart';
import '../models/alphavantage.dart';
import '../services/alphavantage_api.dart';
import './widget_size.dart';

class AddStockForm extends StatefulWidget {
  static const routeName = '/add-stock';

  const AddStockForm({Key? key}) : super(key: key);

  @override
  State<AddStockForm> createState() => _AddStockFormState();
}

class _AddStockFormState extends State<AddStockForm> {
  final stockSearchController = TextEditingController();

  final List<AlphaVantageSearchResult> _searchResults = [];
  double _searchFieldHeight = 0;
  bool _inProgress = false;

  @override
  void dispose() {
    stockSearchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, Object>;
    final Function _onAddStock = routeArgs['onAddStock'] as Function;

    final searchField = WidgetSize(
      onChange: (Size size) {
        setState(() => _searchFieldHeight = size.height);
      },
      child: TextField(
        autofocus: true,
        decoration: const InputDecoration(
          labelText: 'Ticker or name of stock to add',
        ),
        controller: stockSearchController,
        onSubmitted: (_) => _search(),
      ),
    );

    return Scaffold(
      appBar: AppBar(title: const Text("Add stock")),
      body: Card(child: LayoutBuilder(builder: (context, constraints) {
        return Column(
          children: [
            searchField,
            Stack(
              children: [
                SizedBox(
                  height: constraints.maxHeight - _searchFieldHeight,
                  child: ListView.builder(
                    itemBuilder: (ctx, index) {
                      print(_searchResults[index].symbol);
                      return StockSearchResult(
                        searchResult: _searchResults[index],
                        onClick: () => _onAddStock(
                          _transformToStock(_searchResults[index]),
                        ),
                      );
                    },
                    itemCount: _searchResults.length,
                  ),
                ),
                Align(
                  alignment: FractionalOffset.center,
                  child: Container(
                    child: _inProgress
                        ? const Padding(
                            padding: EdgeInsets.all(10),
                            child: CircularProgressIndicator(),
                          )
                        : null,
                  ),
                )
              ],
            ),
          ],
        );
      })),
    );
  }

  void _search() {
    setState(() => _inProgress = true);
    searchForSymbol(stockSearchController.text).then((value) {
      setState(() {
        _searchResults.clear();
        _searchResults.addAll(value);
        _inProgress = false;
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
