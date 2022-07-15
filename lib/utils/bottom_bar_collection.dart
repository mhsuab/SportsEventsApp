library collection_bottom_navbar;

import 'dart:async';
import 'package:flutter/material.dart';

import 'package:bottom_bar_with_sheet/bottom_bar_with_sheet.dart';
import 'package:sports/utils/utils.dart';

class BottomBarCollection extends StatefulWidget {
  BottomBarCollection({
    Key? key,
    required this.collection,
    this.onSelectItem,
    BottomBarWithSheetController? controller,
  })  : _controller = (controller ??
            BottomBarWithSheetController(
              initialIndex: 0,
              sheetOpened: false,
            ))
          ..onItemSelect = onSelectItem,
        super(key: key);

  BottomBarWithSheetController get controller => _controller;

  final Map<SportSwitch, SportData> collection;
  final Function(int)? onSelectItem;
  late final BottomBarWithSheetController _controller;

  final _sportController = StreamController<SportSwitch>.broadcast();
  Stream<SportSwitch> get sportController => _sportController.stream;

  @override
  // ignore: library_private_types_in_public_api
  _BottomBarCollectionState createState() => _BottomBarCollectionState();
}

class _BottomBarCollectionState extends State<BottomBarCollection>
    with SingleTickerProviderStateMixin {
  late AnimationController _arrowAnimationController;
  late Animation _arrowAnimation;
  late bool _isOpened;
  late StreamSubscription _sub;
  late SportSwitch currentSport;

  @override
  void initState() {
    super.initState();
    _arrowAnimationController =
        AnimationController(vsync: this, duration: animationDuration);
    _arrowAnimation =
        Tween(begin: 0.0, end: 1.0).animate(_arrowAnimationController);
    _isOpened = widget._controller.isOpened;
    _configBottomControllerListener();
    currentSport = widget.collection.keys.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: animationDuration,
      curve: Curves.fastOutSlowIn,
      height: _bottomBarHeigth,
      width: MediaQuery.of(context).size.width,
      padding: widget.collection[currentSport]!.bottomBarTheme.contentPadding,
      decoration: widget.collection[currentSport]!.bottomBarTheme.decoration,
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: _generateItems(),
          ),
          _isOpened
              ? Expanded(
                  child: ListView.separated(
                  separatorBuilder: ((context, index) => Divider(
                        color: widget.collection[currentSport]!.bottomBarTheme
                            .itemIconColor,
                        height: 2.0,
                      )),
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemCount: widget.collection.length,
                  itemBuilder: (context, idx) {
                    SportSwitch sport = widget.collection.keys.elementAt(idx);
                    return BottomBarSheetItem(
                      logo: widget.collection[sport]!.logo,
                      title: widget.collection[sport]!.abbr,
                      subtitle: widget.collection[sport]!.name,
                      titleColor: widget.collection[currentSport]!
                          .bottomBarTheme.itemTextStyle?.color,
                      onTap: () {
                        setState(() {
                          currentSport = sport;
                          widget._sportController.add(currentSport);
                          widget._controller.selectItem(0);
                          widget._controller.closeSheet();
                        });
                      },
                    );
                  },
                ))
              : const SizedBox()
        ],
      ),
    );
  }

  void _configBottomControllerListener() {
    _sub = widget._controller.stream
        .listen((event) => setState(() => _isOpened = event));
  }

  List<Widget> _generateItems() {
    return ItemsGenerator.generateByButtonPosition(
      mainActionButton: IgnorePointer(
        ignoring: (widget.collection.length <= 1),
        child: MainActionButton(
          rotationPortion: 0.01,
          onTap: () {
            _changeWidgetState();
          },
          mainActionButtonTheme: MainActionButtonTheme(
              splash: widget.collection[currentSport]!.bottomBarTheme.splash
                      ?.withAlpha(50) ??
                  Colors.black12,
              size: 65,
              color: Colors.transparent,
              icon: CircleAvatar(
                radius: 25.0,
                backgroundImage:
                    AssetImage(widget.collection[currentSport]!.logo),
              )),
          arrowAnimation: _arrowAnimation,
          arrowAnimationController: _arrowAnimationController,
          enable: true,
        ),
      ),
      items: widget.collection[currentSport]!.items
          .asMap()
          .map(
            (i, e) => MapEntry(
              i,
              BottmBarItemController(
                index: i,
                model: BottomBarWithSheetItem(
                  icon: e.icon,
                  label: e.label,
                  disabled: e.disabled,
                ),
                controller: widget._controller,
                theme: widget.collection[currentSport]!.bottomBarTheme,
                disabled: _isOpened,
              ),
            ),
          )
          .values
          .toList(),
      position: MainButtonPosition.right,
    );
  }

  @override
  void dispose() {
    _arrowAnimationController.dispose();
    _sub.cancel();
    super.dispose();
  }

  void _changeWidgetState() {
    widget._controller.toggleSheet();
    if (_arrowAnimationController.isCompleted) {
      _arrowAnimationController.reverse();
    } else {
      _arrowAnimationController.forward();
    }
  }

  double get _bottomBarHeigth {
    return bottomTileHeight *
        (_isOpened ? (widget.collection.length == 2 ? 3.7 : 3.2) : 1);
  }
}

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
          leading: CircleAvatar(
            radius: 20.0,
            backgroundImage: AssetImage(logo),
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
