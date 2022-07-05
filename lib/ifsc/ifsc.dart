import 'package:flutter/material.dart';
import 'package:sports/ifsc/pages/pages.dart';
import 'package:sports/utils/utils.dart';

String _baseUrl = "https://components.ifsc-climbing.org/results-api.php";
ThemeData wimbledonTheme = ThemeData(
  colorSchemeSeed: Colors.green,
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xff1b2839),
    foregroundColor: Colors.white,
  ),
);

ThemeData theme = ThemeData(
  colorSchemeSeed: const Color(0xff1b2839),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xff1b2839),
    foregroundColor: Colors.white,
  ),
);

SportData ifsc = SportData(
  theme: theme,
  logo: 'assets/ifsc.png',
  items: [
    SportTab(icon: Icons.event, label: 'events', page: EventPage()),
    SportTab(
        icon: Icons.leaderboard,
        label: 'ranking',
        page: Ranking(title: "Salt Lake City")),
    const SportTab(icon: Icons.groups, label: 'athletes', page: Athletes()),
    const SportTab(icon: Icons.bookmark, label: 'followed', disabled: true),
  ],
  baseUrl: _baseUrl,
  background: const Color(0xff1b2839),
  icon: Colors.white,
  text: Colors.white,
  selectedIcon: const Color(0xffe6007e),
  selectedText: const Color(0xff01a2e4),
  splash: const Color(0xff01a2e4),
);
