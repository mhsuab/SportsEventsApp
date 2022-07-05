import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sports/utils/utils.dart';

void main() => runApp(const SportsApp());

class SportsApp extends StatefulWidget {
  const SportsApp({Key? key}) : super(key: key);

  @override
  State<SportsApp> createState() => _SportsAppState();
}

class _SportsAppState extends State<SportsApp> {
  final GlobalKey<NavigatorState> _navigator = GlobalKey<NavigatorState>();
  late BottomBarCollection _bottomBarCollection;

  late int _initialIdx;
  SportSwitch _currentSport = sports.keys.first;

  late final StreamSubscription _subSport;

  @override
  void initState() {
    _bottomBarCollection = BottomBarCollection(
      collection: sports,
      onSelectItem: (index) => _updateIndex(index),
    );
    _initialIdx = _bottomBarCollection.controller.selectedIndex;
    _subSport = _bottomBarCollection.sportController
        .listen((sport) => setState((() => _currentSport = sport)));
    super.initState();
  }

  @override
  void dispose() {
    _subSport.cancel();
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
                    titleTextStyle: GoogleFonts.staatliches().copyWith(
                      fontSize: 28,
                    ),
                    actionsIconTheme: const IconThemeData(
                      size: 28,
                    ),
                    toolbarHeight: 48,
                  ),
            ),
        home: Scaffold(
          body: WillPopScope(
              onWillPop: () async => _navigator.currentState!.maybePop(),
              child: Navigator(
                  key: _navigator,
                  onGenerateRoute: (setting) {
                    return PageRouteBuilder(
                        pageBuilder: (BuildContext context,
                                Animation<double> animation,
                                Animation<double> secondaryAnimation) =>
                            sports[_currentSport]!.items[_initialIdx].page);
                  })),
          bottomNavigationBar: _bottomBarCollection,
        ));
  }
}
