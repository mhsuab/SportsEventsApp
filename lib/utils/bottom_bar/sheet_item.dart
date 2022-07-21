import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sports/utils/utils.dart';

class BottomBarSheetItem extends StatelessWidget {
  const BottomBarSheetItem({
    Key? key,
    required this.sport,
    this.titleColor,
  }) : super(key: key);

  final SportSwitch sport;
  final Color? titleColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: bottomTileHeight,
      child: Center(
        child: ListTile(
          leading: SizedBox(
            height: 40,
            width: 40,
            child: Image.asset(sports[sport]!.logo),
          ),
          title: Text(sports[sport]!.abbr),
          textColor: titleColor,
          subtitle: Text(sports[sport]!.name),
          onTap: () => Provider.of<PageManager>(context, listen: false)
              .changeSport(sport),
        ),
      ),
    );
  }
}
