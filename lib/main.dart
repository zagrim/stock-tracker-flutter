import 'package:flutter/material.dart';

import 'widgets/add_stock_form.dart';
import 'widgets/stock_list_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stock tracker',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        textTheme: ThemeData.light().textTheme.copyWith(
              subtitle1: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
              subtitle2: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
              bodyText2: const TextStyle(
                fontSize: 12,
              ),
            ),
      ),
      home: const StockListPage(title: 'Stocks'),
      routes: {
        AddStockForm.routeName: (context) => AddStockForm(),
      },
    );
  }
}
