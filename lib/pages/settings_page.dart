import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';

class SettingsPage extends StatefulWidget {
  static const routeName = '/settings';

  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      drawer: const MainDrawer(),
      body: Column(
        children: [
          ListTile(
            title: const Text('aksjf'),
          )
        ],
      ),
    );
  }
}
