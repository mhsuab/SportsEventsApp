import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sports/utils/utils.dart';

import 'sheet.dart';
import 'sport_button.dart';
import 'tab.dart';

class BottomBarCollection extends StatelessWidget {
  const BottomBarCollection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pageManager = Provider.of<PageManager>(context, listen: true);
    return AnimatedContainer(
      duration: animationDuration,
      curve: Curves.fastOutSlowIn,
      height: bottomTileHeight *
          (pageManager.isOpened ? (sports.length == 2 ? 3.2 : 3.7) : 1),
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 0.0),
      decoration: BoxDecoration(
        color: pageManager.data.background,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(30.0),
        ),
      ),
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ...pageManager.data.items
                  .asMap()
                  .map(
                    (index, tab) => MapEntry(
                      index,
                      BottomBarTab(
                        data: pageManager.data,
                        tab: tab,
                        index: index,
                        isSelected: pageManager.isSelected(index),
                        disabled: !pageManager.isOpened && !tab.disabled,
                      ),
                    ),
                  )
                  .values
                  .toList(),
              SportButton(
                splash: pageManager.data.splash,
                buttonImage: pageManager.data.logo,
                onTap: () => Provider.of<PageManager>(context, listen: false)
                    .toggleBar(),
                disabled: (sports.length <= 1),
              ),
            ],
          ),
          pageManager.isOpened
              ? BottomBarSheet(data: pageManager.data)
              : const SizedBox()
        ],
      ),
    );
  }
}
