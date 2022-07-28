import 'package:flutter/material.dart';
import 'package:sports/ifsc/ifsc.dart';

import 'custom_page.dart';

enum SportSwitch {
  ifsc,
  wimbledon,
}

Map<SportSwitch, SportData> sports = {
  SportSwitch.ifsc: ifsc,
};

class SportTab {
  final IconData icon;
  final bool disabled;
  final bool isTab;
  final String label;
  final Page _initPage;
  GlobalKey<NavigatorState> navigator = GlobalKey<NavigatorState>();

  SportTab({
    required this.icon,
    required this.label,
    this.disabled = false,
    this.isTab = true,
    Widget child = const SizedBox(),
  }) : _initPage = CustomPage(child: child);

  Page get page => _initPage;
}

class SportData {
  final ThemeData theme;
  final String logo;
  final List<SportTab> items;
  final String? baseUrl;
  final String abbr;
  final String name;

  // bottom bar theme
  final Color icon;
  final Color text;
  final Color selectedIcon;
  final Color selectedText;
  final Color background;
  final Color? disabledIcon;
  final Color? disabledText;
  final Color? splash;

  SportData({
    required this.theme,
    required this.logo,
    required this.items,
    this.baseUrl,
    required this.icon,
    required this.text,
    required this.selectedIcon,
    required this.selectedText,
    required this.background,
    this.disabledIcon = Colors.white38,
    this.disabledText = Colors.white38,
    this.splash = Colors.black12,
    required this.abbr,
    required this.name,
  });
}
