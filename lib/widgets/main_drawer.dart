import 'package:flutter/material.dart';

import '../pages/settings_page.dart';
import '../pages/stock_list_page.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  buildDrawerItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, size: 26),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: [
        const SizedBox(
          height: 40,
        ),
        buildDrawerItem(
          Icons.format_list_bulleted_outlined,
          'My stocks',
          () {
            Navigator.of(context).pushReplacementNamed(StockListPage.routeName);
          },
        ),
        buildDrawerItem(
          Icons.settings,
          'Settings',
          () {
            Navigator.of(context).pushReplacementNamed(SettingsPage.routeName);
          },
        )
      ]),
    );
  }
}
