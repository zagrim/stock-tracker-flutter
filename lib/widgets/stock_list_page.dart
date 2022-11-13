import 'package:flutter/material.dart';
import './stock_list.dart';
import './add_stock_form.dart';
import '../models/stock.dart';

class StockListPage extends StatefulWidget {
  const StockListPage({Key? key, required this.title}) : super(key: key);

  @override
  State<StockListPage> createState() => _StockListPageState();

  final String title;
}

class _StockListPageState extends State<StockListPage> {
  final List<Stock> _stocks = [
    Stock('QTCOM', 'Qt Group Oyj', 'EUR', DateTime.now(), 135.60, -0.008),
    Stock('MUSTI', 'Musti Group Oyj', 'EUR', DateTime.now(), 30.43, 0.0032),
  ];
  late double _appBarHeight;
  var _showAddForm = false;

  @override
  Widget build(BuildContext context) {
    final _appBar = AppBar(
      title: Text(widget.title),
      actions: [
        IconButton(
          onPressed: () {
            setState(() {
              _showAddForm = !_showAddForm;
            });
          }, //_onShowModal(context),
          icon: const Icon(Icons.add),
        ),
      ],
    );
    _appBarHeight = _appBar.preferredSize.height;

    return Scaffold(
      appBar: _appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (_showAddForm)
              SizedBox(
                height: MediaQuery.of(context).size.height -
                    _appBarHeight -
                    MediaQuery.of(context).padding.vertical,
                child: AddStockForm(_onAddStock),
              ),
            if (!_showAddForm)
              SizedBox(
                height: MediaQuery.of(context).size.height -
                    _appBarHeight -
                    MediaQuery.of(context).padding.vertical,
                child: StockList(stockList: _stocks),
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
    );
  }

  void _onAddStock(Stock stock) {
    // TODO: fetch data for the added stock
    setState(() {
      _stocks.add(stock);
      _showAddForm = false;
    });
  }
}
