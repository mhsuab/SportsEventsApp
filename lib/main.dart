import 'package:sports/ifsc/ranking/ranking.dart';
import 'package:sports/nav_bar/navbar.dart';
import 'package:sports/ifsc/discipline/discipline.dart';

import 'package:bottom_bar_with_sheet/bottom_bar_with_sheet.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          colorSchemeSeed: const Color(0xff1b2839),
          useMaterial3: true,
          textTheme: GoogleFonts.ubuntuMonoTextTheme()),
      home: const MyHomePage(title: 'title'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _bottomController = BottomBarWithSheetController(initialIndex: 0);
  final _ifscNavBar = const CustomBottomNavBar(
    items: [
      BottomBarWithSheetItem(icon: Icons.event, label: 'events'),
      BottomBarWithSheetItem(icon: Icons.leaderboard, label: 'ranking'),
      BottomBarWithSheetItem(icon: Icons.groups, label: 'athletes'),
      BottomBarWithSheetItem(icon: Icons.bookmark, label: 'followed'),
    ],
    logoImgPath: 'assets/ifsc/logo.png',
    bottomBarTheme: BottomBarTheme(
      selectedItemTextStyle: TextStyle(color: Color(0xff01a2e4), fontSize: 12),
      itemTextStyle: TextStyle(color: Colors.white, fontSize: 12),
      height: 80,
      heightClosed: 80,
      heightOpened: 500,
      mainButtonPosition: MainButtonPosition.right,
      selectedItemIconColor: Color(0xffe6007e),
      itemIconColor: Colors.white,
      decoration: BoxDecoration(
        color: Color(0xff1b2839),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30.0),
        ),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RankingPage(items: const <Discipline>[
        Discipline.general,
        Discipline.boulder,
        Discipline.lead,
        Discipline.speed,
      ]),
      bottomNavigationBar: CustomSingleBottomNavBar(
        sheetChild: Center(
          child: Text(
            "Another content",
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 20,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        navbar: _ifscNavBar,
        controller: _bottomController,
        onSelectItem: (index) => debugPrint('$index'),
      ),
    );
  }
}
