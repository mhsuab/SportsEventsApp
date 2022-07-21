import 'package:flutter/material.dart';
import 'package:sports/utils/custom_page.dart';

export 'base_single_page.dart';
export 'bottom_bar/bottom_bar.dart';
export 'switch.dart';
export 'custom_page.dart';
export 'constants.dart';
export 'page_manager.dart';

enum SportSwitch {
  ifsc,
  wimbledon,
  ifsc1,
  ifsc2,
  ifsc3,
  ifsc4,
  ifsc5,
}

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
