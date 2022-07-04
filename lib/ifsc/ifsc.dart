import 'package:bottom_bar_with_sheet/bottom_bar_with_sheet.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sports/ifsc/pages/pages.dart';
import 'package:sports/utils/utils.dart';

String _baseUrl = "https://components.ifsc-climbing.org/results-api.php";
ThemeData wimbledonTheme = ThemeData(
  colorSchemeSeed: Colors.green,
  useMaterial3: true,
  textTheme: GoogleFonts.ubuntuMonoTextTheme(),
  appBarTheme: AppBarTheme(
    titleTextStyle: GoogleFonts.staatliches().copyWith(
      fontSize: 28,
    ),
    backgroundColor: const Color(0xff1b2839),
    foregroundColor: Colors.white,
    actionsIconTheme: const IconThemeData(
      size: 28,
    ),
    toolbarHeight: 48,
  ),
);

ThemeData theme = ThemeData(
  colorSchemeSeed: const Color(0xff1b2839),
  useMaterial3: true,
  textTheme: GoogleFonts.ubuntuMonoTextTheme(),
  appBarTheme: AppBarTheme(
    titleTextStyle: GoogleFonts.staatliches().copyWith(
      fontSize: 28,
    ),
    backgroundColor: const Color(0xff1b2839),
    foregroundColor: Colors.white,
    actionsIconTheme: const IconThemeData(
      size: 28,
    ),
    toolbarHeight: 48,
  ),
);

BottomBarTheme bottomBarTheme = const BottomBarTheme(
  selectedItemTextStyle: TextStyle(color: Color(0xff01a2e4), fontSize: 12),
  itemTextStyle: TextStyle(color: Colors.white, fontSize: 12),
  disabledItemIconColor: Colors.white38,
  disabledItemTextStyle: TextStyle(color: Colors.white38),
  height: 80,
  heightClosed: 80,
  heightOpened: 270, // height of icons/labels & sheet
  mainButtonPosition: MainButtonPosition.right,
  selectedItemIconColor: Color(0xffe6007e),
  itemIconColor: Colors.white,
  decoration: BoxDecoration(
    color: Color(0xff1b2839),
    borderRadius: BorderRadius.only(
      topRight: Radius.circular(30.0),
    ),
  ),
);

SportData ifsc = SportData(
  theme: theme,
  bottomBarTheme: bottomBarTheme,
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
);
