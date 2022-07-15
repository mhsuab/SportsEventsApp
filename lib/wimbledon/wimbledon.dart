import 'package:flutter/material.dart';
import 'package:sports/utils/utils.dart';

ThemeData wimbledonTheme = ThemeData(
  colorSchemeSeed: Colors.green,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.green,
    foregroundColor: Colors.white,
  ),
);

SportData wimbledon = SportData(
  abbr: 'WIMBLEDON',
  name: 'The Championships, Wimbledon',
  theme: wimbledonTheme,
  logo: 'assets/wimbledon.png',
  items: [
    SportTab(
      icon: Icons.add_box,
      label: 'add',
      page: const BaseSinglePage(
        page: Center(child: Text("add")),
        appbarTitle: 'add',
      ),
    ),
    SportTab(
      icon: Icons.qr_code,
      label: 'scan',
      page: const BaseSinglePage(
        page: Center(child: Text("scan")),
        appbarTitle: 'scan',
      ),
    ),
    SportTab(
      icon: Icons.event,
      label: 'events',
      page: const BaseSinglePage(
        page: Center(child: Text("wimbledon")),
        appbarTitle: 'wimbledon',
      ),
    ),
  ],
  background: Colors.lightGreen,
  icon: Colors.black,
  text: Colors.black,
  selectedIcon: const Color.fromARGB(255, 69, 222, 233),
  selectedText: const Color.fromARGB(255, 228, 122, 1),
  splash: const Color.fromARGB(255, 1, 228, 43),
);
