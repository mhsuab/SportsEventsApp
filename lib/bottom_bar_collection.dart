library collection_bottom_navbar;

import 'dart:async';
import 'package:flutter/material.dart';

import 'package:bottom_bar_with_sheet/bottom_bar_with_sheet.dart';
import 'package:sports/utils/utils.dart';

class BottomBarCollection extends StatefulWidget {
  BottomBarCollection({
    Key? key,
    required this.collection,
    // this.sheetChild,
    this.onSelectItem,
    BottomBarWithSheetController? controller,
  })  : _controller = (controller ??
            BottomBarWithSheetController(
              initialIndex: 0,
              sheetOpened: false,
            ))
          ..onItemSelect = onSelectItem,
        super(key: key);

  final Duration duration = const Duration(milliseconds: 700);
  final Curve curve = Curves.fastOutSlowIn;

  // final List<BaseBottomBar> collection;
  final Map<SportSwitch, SportData> collection;
  // final Widget? sheetChild;
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
        AnimationController(vsync: this, duration: widget.duration);
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
      duration: widget.duration,
      curve: widget.curve,
      height: _bottomBarHeigth,
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
                  child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemCount: widget.collection.length,
                  itemBuilder: (context, idx) {
                    SportSwitch sport = widget.collection.keys.elementAt(idx);
                    return ElevatedButton(
                        onPressed: () {
                          setState(() {
                            currentSport = sport;
                            widget._sportController.add(currentSport);
                            widget._controller.selectItem(0);
                            widget._controller.closeSheet();
                          });
                        },
                        child: Text(sport.name));
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
      mainActionButton: MainActionButton(
        rotationPortion: 0,
        onTap: () {
          _changeWidgetState();
        },
        // button: widget.mainActionButtonBuilder?.call(context),
        mainActionButtonTheme: MainActionButtonTheme(
            splash: ((widget.collection[currentSport]!.bottomBarTheme
                            .selectedItemTextStyle?.color ??
                        Theme.of(context)
                            .bottomNavigationBarTheme
                            .selectedLabelStyle
                            ?.color))
                    ?.withAlpha(50) ??
                Colors.transparent,
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
                    disabled: e.disabled ?? false),
                controller: widget._controller,
                theme: widget.collection[currentSport]!.bottomBarTheme,
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
    final t = widget.collection[currentSport]!.bottomBarTheme;
    return _isOpened ? t.heightOpened : t.heightClosed;
  }
}
