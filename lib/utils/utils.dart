import 'package:bottom_bar_with_sheet/bottom_bar_with_sheet.dart';
import 'package:flutter/material.dart';

enum SportSwitch { ifsc, wimbledon, ifsc1, ifsc2, ifsc3, ifsc4, ifsc5 }

class SportTab {
  final IconData icon;
  final Widget? page;
  final String? label;
  final bool? disabled;

  const SportTab({
    required this.icon,
    this.page,
    this.label,
    this.disabled,
  }) : assert(page != null || (page == null && disabled == true));
}

class SportData {
  final ThemeData theme;
  final BottomBarTheme bottomBarTheme;
  final String logo;
  final List<SportTab> items;
  final String? baseUrl;

  const SportData({
    required this.theme,
    required this.bottomBarTheme,
    required this.logo,
    required this.items,
    this.baseUrl,
  });
}
