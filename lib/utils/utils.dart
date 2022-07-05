import 'package:bottom_bar_with_sheet/bottom_bar_with_sheet.dart';
import 'package:flutter/material.dart';

export 'base_single_page.dart';
export 'bottom_bar_collection.dart';
export 'switch.dart';

enum SportSwitch { ifsc, wimbledon }

class SportTab {
  final IconData icon;
  final Widget page;
  final bool disabled;
  final String? label;

  const SportTab({
    required this.icon,
    this.page = const SizedBox(),
    this.disabled = false,
    this.label,
  });
}

class SportData {
  final ThemeData theme;
  final BottomBarTheme bottomBarTheme;
  final String logo;
  final List<SportTab> items;
  final String? baseUrl;

  SportData({
    required this.theme,
    required this.logo,
    required this.items,
    this.baseUrl,
    required Color icon,
    required Color text,
    required Color selectedIcon,
    required Color selectedText,
    required Color background,
    Color? disabledIcon,
    Color? disabledText,
    Color? splash,
  }) : bottomBarTheme = BottomBarTheme(
          selectedItemIconColor: selectedIcon,
          selectedItemTextStyle: TextStyle(color: selectedText, fontSize: 12),
          itemIconColor: icon,
          itemTextStyle: TextStyle(color: text, fontSize: 12),
          disabledItemIconColor: disabledIcon ?? Colors.white38,
          disabledItemTextStyle:
              TextStyle(color: disabledText ?? Colors.white38),
          height: 80,
          heightClosed: 80,
          heightOpened: 270, // height of icons/labels & sheet
          mainButtonPosition: MainButtonPosition.right,
          decoration: BoxDecoration(
            color: background,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(30.0),
            ),
          ),
          splash: splash ?? Colors.black12,
        );
}
