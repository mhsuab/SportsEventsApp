library single_bottom_navbar;

import 'dart:async';
import 'package:flutter/material.dart';

import 'package:bottom_bar_with_sheet/bottom_bar_with_sheet.dart';
import 'package:sports/nav_bar/custom_bottom_navbar.dart';

class CustomSingleBottomNavBar extends StatefulWidget {
  CustomSingleBottomNavBar({
    Key? key,
    required this.navbar,
    this.sheetChild,
    this.onSelectItem,
    this.controller,
  })  : _controller = (controller ??
            BottomBarWithSheetController(
              initialIndex: 0,
              sheetOpened: false,
            ))
          ..onItemSelect = onSelectItem,
        super(key: key);

  final Duration duration = const Duration(milliseconds: 700);
  final Curve curve = Curves.fastOutSlowIn;

  final CustomBottomNavBar navbar;
  final Widget? sheetChild;
  final Function(int)? onSelectItem;
  final BottomBarWithSheetController? controller;
  late final BottomBarWithSheetController _controller;

  final int sportIndex = 0;
  // final int _tabIndex = 0;

  @override
  _CustomSingleBottomNavBarState createState() =>
      _CustomSingleBottomNavBarState();
}

class _CustomSingleBottomNavBarState extends State<CustomSingleBottomNavBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _arrowAnimationController;
  late Animation _arrowAnimation;
  late bool _isOpened;
  late StreamSubscription _sub;

  @override
  void initState() {
    super.initState();
    _arrowAnimationController =
        AnimationController(vsync: this, duration: widget.duration);
    _arrowAnimation =
        Tween(begin: 0.0, end: 1.0).animate(_arrowAnimationController);
    _isOpened = widget._controller.isOpened;
    _configBottomControllerListener();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: widget.duration,
      curve: widget.curve,
      height: _bottomBarHeigth,
      padding: widget.navbar.bottomBarTheme.contentPadding,
      decoration: widget.navbar.bottomBarTheme.decoration,
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: _generateItems(),
          ),
          _isOpened
              ? Expanded(child: widget.sheetChild ?? const SizedBox())
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
        rotationPortion: 0.05,
        onTap: () {
          _changeWidgetState();
        },
        // button: widget.mainActionButtonBuilder?.call(context),
        mainActionButtonTheme: MainActionButtonTheme(
            size: 65,
            color: Colors.transparent,
            icon: CircleAvatar(
              radius: 25.0,
              backgroundImage: AssetImage(widget.navbar.logoImgPath),
            )),
        arrowAnimation: _arrowAnimation,
        arrowAnimationController: _arrowAnimationController,
        enable: true,
      ),
      items: widget.navbar.items
          .asMap()
          .map(
            (i, e) => MapEntry(
              i,
              BottmBarItemController(
                index: i,
                model: e,
                controller: widget._controller,
                theme: widget.navbar.bottomBarTheme,
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
    final t = widget.navbar.bottomBarTheme;
    return _isOpened ? t.heightOpened : t.heightClosed;
  }
}
