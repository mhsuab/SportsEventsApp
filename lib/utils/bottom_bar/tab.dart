import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sports/utils/utils.dart';

class BottomBarTab extends StatelessWidget {
  final SportData data;
  final SportTab tab;
  final int index;
  final bool isSelected;
  final bool disabled;

  const BottomBarTab({
    Key? key,
    required this.data,
    required this.tab,
    required this.index,
    required this.isSelected,
    required this.disabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () {
          if (disabled) {
            Provider.of<PageManager>(context, listen: false).changeTab(index);
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              tab.icon,
              color: isSelected
                  ? data.selectedIcon
                  : (tab.disabled ? data.disabledIcon : data.icon),
              size: isSelected ? 24 : 22,
            ),
            ...[
              const SizedBox(height: 2),
              Text(
                tab.label,
                style: isSelected
                    ? TextStyle(
                        color: data.selectedText,
                        fontSize: 12,
                      )
                    : (tab.disabled
                        ? TextStyle(
                            color: data.disabledText,
                            fontSize: 12,
                          )
                        : TextStyle(
                            color: data.text,
                            fontSize: 12,
                          )),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
