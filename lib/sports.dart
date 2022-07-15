import 'dart:async';
import 'dart:ui';

import 'package:bottom_bar_with_sheet/bottom_bar_with_sheet.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:sports/utils/utils.dart';

class SportsApp extends StatefulWidget {
  const SportsApp({Key? key}) : super(key: key);

  @override
  State<SportsApp> createState() => _SportsAppState();
}

class _SportsAppState extends State<SportsApp> {
  final Color _appBackground = const Color(0xffeeeeee);
  final GlobalKey<NavigatorState> _navigator = GlobalKey<NavigatorState>();
  late BottomBarCollection _bottomBarCollection;
  final BottomBarWithSheetController _controller =
      BottomBarWithSheetController(initialIndex: 0, sheetOpened: false);

  late int _initialIdx;
  late bool _isOpen;
  late SportSwitch _currentSport = sports.keys.first;

  late final StreamSubscription _subSport;
  late final StreamSubscription _subOpen;

  @override
  void initState() {
    _bottomBarCollection = BottomBarCollection(
      controller: _controller,
      collection: sports,
      onSelectItem: (index) => _updateIndex(index),
    );
    _isOpen = _controller.isOpened;
    _initialIdx = _bottomBarCollection.controller.selectedIndex;
    _subSport = _bottomBarCollection.sportController
        .listen((sport) => setState((() => _currentSport = sport)));
    _subOpen =
        _controller.stream.listen((event) => setState((() => _isOpen = event)));
    super.initState();
  }

  @override
  void dispose() {
    _subSport.cancel();
    _subOpen.cancel();
    super.dispose();
  }

  void _updateIndex(index) {
    _navigator.currentState?.pushAndRemoveUntil(
        PageRouteBuilder(
          pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation) =>
              sports[_currentSport]!.items[index].page,
        ),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: sports[_currentSport]!.theme.copyWith(
            useMaterial3: true,
            textTheme: GoogleFonts.ubuntuMonoTextTheme(),
            appBarTheme: sports[_currentSport]!.theme.appBarTheme.copyWith(
                  titleTextStyle: GoogleFonts.staatliches(
                    fontSize: 28,
                  ),
                  actionsIconTheme: const IconThemeData(
                    size: 28,
                  ),
                  toolbarHeight: 48,
                ),
            scaffoldBackgroundColor: _appBackground,
          ),
      home: Stack(
        alignment: Alignment.centerLeft,
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: Container(
              color: _appBackground,
            ),
          ),
          Positioned.fill(
            bottom: bottomTileHeight,
            child: WillPopScope(
              onWillPop: () async => _navigator.currentState!.maybePop(),
              child: Navigator(
                  key: _navigator,
                  onGenerateRoute: (setting) {
                    return PageRouteBuilder(
                        pageBuilder: (BuildContext context,
                                Animation<double> animation,
                                Animation<double> secondaryAnimation) =>
                            sports[_currentSport]!.items[_initialIdx].page);
                  }),
            ),
          ),
          IgnorePointer(
            ignoring: !_isOpen,
            child: AnimatedOpacity(
              opacity: _isOpen ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 200),
              curve: Curves.decelerate,
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 5.0,
                  sigmaY: 5.0,
                ),
                child: Container(
                  color: Colors.black.withOpacity(0.2),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Material(
              color: Colors.transparent,
              child: _bottomBarCollection,
            ),
          ),
        ],
      ),
    );
  }
}
