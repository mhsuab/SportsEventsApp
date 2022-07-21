library bottom_bar_button;

import 'package:flutter/material.dart';
import 'package:sports/utils/utils.dart';

class BottomBarSheetItem extends StatelessWidget {
  const BottomBarSheetItem({
    Key? key,
    required this.logo,
    required this.title,
    this.titleColor,
    required this.subtitle,
    required this.onTap,
  }) : super(key: key);

  final String logo;
  final String title;
  final Color? titleColor;
  final String subtitle;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: bottomTileHeight,
      child: Center(
        child: ListTile(
          leading: SizedBox(
            height: 40,
            width: 40,
            child: Image.asset(logo),
          ),
          title: Text(title),
          textColor: titleColor,
          subtitle: Text(subtitle),
          onTap: onTap,
        ),
      ),
    );
  }
}
