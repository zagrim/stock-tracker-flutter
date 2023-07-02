import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import './providers/stock_portfolio.dart';
import './models/global_settings.dart';
import './pages/settings_page.dart';
import './widgets/add_stock_form.dart';
import './pages/stock_list_page.dart';

void main() {
  GetIt.instance.registerSingleton(GlobalSettings());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<StockPortfolio>(create: (_) => StockPortfolio()),
        /*Provider<SomethingElse>(create: (_) => SomethingElse()),
        Provider<AnotherThing>(create: (_) => AnotherThing()),*/
      ],
      child: MaterialApp(
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
                  fontSize: 18,
                ),
                subtitle2: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                bodyText2: const TextStyle(
                  fontSize: 16,
                ),
              ),
        ),
        home: GetIt.instance.get<GlobalSettings>().isApiKeySet()
            ? const StockListPage()
            : const SettingsPage(),
        routes: {
          StockListPage.routeName: (context) => const StockListPage(),
          AddStockForm.routeName: (context) => const AddStockForm(),
          SettingsPage.routeName: (context) => const SettingsPage(),
        },
      ),
    );
  }
}
