import 'package:flutter/material.dart';
import 'package:sports/utils/utils.dart';

import 'sheet_item.dart';

class BottomBarSheet extends StatelessWidget {
  final SportData data;
  const BottomBarSheet({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        padding: EdgeInsets.zero,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        separatorBuilder: (context, index) => Divider(
          color: data.icon,
          height: 2.0,
        ),
        itemCount: sports.length,
        itemBuilder: (context, index) => BottomBarSheetItem(
          sport: sports.keys.elementAt(index),
          titleColor: data.text,
        ),
      ),
    );
  }
}
