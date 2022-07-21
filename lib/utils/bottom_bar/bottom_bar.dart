library bottom_bar;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sports/utils/utils.dart';

import 'bottom_bar_button.dart';
import 'bottom_bar_sheet_item.dart';

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
              BottomBarButton(
                splash: pageManager.data.splash,
                buttonImage: pageManager.data.logo,
                onTap: () => Provider.of<PageManager>(context, listen: false)
                    .toggleBar(),
                disabled: (sports.length <= 1),
              ),
              ...pageManager.data.items
                  .asMap()
                  .map(
                    (i, e) => MapEntry(
                      i,
                      Expanded(
                        child: InkWell(
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            if (!pageManager.isOpened && !e.disabled) {
                              Provider.of<PageManager>(context, listen: false)
                                  .changeTab(i);
                            }
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                e.icon,
                                color: pageManager.isSelected(i)
                                    ? pageManager.data.selectedIcon
                                    : (e.disabled
                                        ? pageManager.data.disabledIcon
                                        : pageManager.data.icon),
                                size: pageManager.isSelected(i) ? 24 : 22,
                              ),
                              ...[
                                const SizedBox(height: 2),
                                Text(e.label,
                                    style: pageManager.isSelected(i)
                                        ? TextStyle(
                                            color:
                                                pageManager.data.selectedText,
                                            fontSize: 12)
                                        : (e.disabled
                                            ? TextStyle(
                                                color: pageManager
                                                    .data.disabledText,
                                                fontSize: 12)
                                            : TextStyle(
                                                color: pageManager.data.text,
                                                fontSize: 12)))
                              ]
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                  .values
                  .toList(),
            ],
          ),
          pageManager.isOpened
              ? Expanded(
                  child: ListView.separated(
                  separatorBuilder: ((context, index) => Divider(
                        color: pageManager.data.icon,
                        height: 2.0,
                      )),
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemCount: sports.length,
                  itemBuilder: (context, idx) {
                    SportSwitch sport = sports.keys.elementAt(idx);
                    return BottomBarSheetItem(
                      logo: sports[sport]!.logo,
                      title: sports[sport]!.abbr,
                      subtitle: sports[sport]!.name,
                      titleColor: pageManager.data.text,
                      onTap: () {
                        Provider.of<PageManager>(context, listen: false)
                            .changeSport(sport);
                      },
                    );
                  },
                ))
              : const SizedBox()
        ],
      ),
    );
  }
}
