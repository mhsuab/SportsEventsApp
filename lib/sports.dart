import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:sports/utils/utils.dart';

class SportsApp extends StatelessWidget {
  const SportsApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pageManager = Provider.of<PageManager>(context, listen: true);
    return MaterialApp(
      theme: pageManager.data.theme.copyWith(
        useMaterial3: true,
        textTheme: GoogleFonts.ubuntuMonoTextTheme(),
        appBarTheme: pageManager.data.theme.appBarTheme.copyWith(
          titleTextStyle: GoogleFonts.staatliches(
            fontSize: 28,
          ),
          actionsIconTheme: const IconThemeData(
            size: 28,
          ),
          toolbarHeight: 48,
        ),
        scaffoldBackgroundColor: appBackground,
      ),
      home: Stack(
        alignment: Alignment.centerLeft,
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: Container(
              color: appBackground,
            ),
          ),
          Positioned.fill(
            bottom: bottomTileHeight,
            child: WillPopScope(
              child: Navigator(
                key: pageManager.tab.navigator,
                pages: pageManager.pages,
                onPopPage: (route, result) {
                  Provider.of<PageManager>(context, listen: false).pop();
                  return route.didPop(result);
                },
              ),
              onWillPop: () async =>
                  pageManager.tab.navigator.currentState!.maybePop(),
            ),
          ),
          IgnorePointer(
            ignoring: !pageManager.isOpened,
            child: AnimatedOpacity(
              opacity: pageManager.isOpened ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 500),
              curve: Curves.fastLinearToSlowEaseIn,
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
          const Positioned(
            bottom: 0,
            child: Material(
              color: Colors.transparent,
              child: BottomBarCollection(),
            ),
          ),
        ],
      ),
    );
  }
}
