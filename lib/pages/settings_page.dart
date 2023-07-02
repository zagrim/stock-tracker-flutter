import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    apiKeyController.addListener(() {
      GetIt.instance.get<GlobalSettings>().alphaVantageApiKey =
          apiKeyController.text;
      _savePrefs();
      print("api key set to ");
      print(GetIt.instance.get<GlobalSettings>().alphaVantageApiKey);
    });
    _initPrefs();
  }

  @override
  void dispose() {
    apiKeyController.dispose();
    super.dispose();
  }

// TODO: move to app initialization (to not show settings view if api key exists)
  void _initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    final settingsData = prefs.getString('settings') ?? '{}';
    print('settingsData');
    print(settingsData);
    final settings = json.decode(settingsData) as Map<String, dynamic>;
    apiKeyController.text = (settings['alphaVantageApiKey'] ?? '') as String;
    //GetIt.instance.get<GlobalSettings>().
  }

// TODO: call this when navigating away.. RouteAwareWidgetState?
// https://stackoverflow.com/a/53089924/2745865
  void _savePrefs() {
    final settingsData =
        json.encode({'alphaVantageApiKey': apiKeyController.text});
    prefs.setString('settings', settingsData);
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
    // TODO add persistence and validation
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
