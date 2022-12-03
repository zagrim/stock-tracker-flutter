import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:stock_tracker/models/global_settings.dart';

import '../widgets/main_drawer.dart';

class SettingsPage extends StatefulWidget {
  static const routeName = '/settings';

  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final apiKeyController = TextEditingController(
    text: GetIt.instance.get<GlobalSettings>().alphaVantageApiKey,
  );

  @override
  void initState() {
    super.initState();
    apiKeyController.addListener(() {
      GetIt.instance.get<GlobalSettings>().alphaVantageApiKey =
          apiKeyController.text;
      print("api key set to ");
      print(GetIt.instance.get<GlobalSettings>().alphaVantageApiKey);
    });
  }

  @override
  void dispose() {
    apiKeyController.dispose();
    super.dispose();
  }

  ListTile buildSettingsItem(
    String labelText,
    String hintText,
    TextEditingController controller,
  ) {
    return ListTile(
      title: TextField(
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(fontSize: 14),
          hintText: hintText,
          hintStyle: const TextStyle(fontSize: 13),
        ),
        controller: controller,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      drawer: const MainDrawer(),
      body: Column(
        children: [
          const ListTile(
            title: Text(
              'Alpha Vantage',
              textAlign: TextAlign.left,
            ),
          ),
          buildSettingsItem(
            'Alpha Vantage API key',
            'Your personal API key for Alpha Vantage',
            apiKeyController,
          ),
        ],
      ),
    );
  }
}
