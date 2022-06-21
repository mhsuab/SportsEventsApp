import 'package:bottom_bar_with_sheet/bottom_bar_with_sheet.dart';
import 'package:sports/nav_bar/navbar.dart';
import 'package:flutter/material.dart';
import 'package:sports/nav_bar/single_bottom_navbar.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
      BottomBarWithSheetItem(icon: Icons.home_rounded, label: 'live'),
      BottomBarWithSheetItem(icon: Icons.home_rounded, label: 'home'),
      BottomBarWithSheetItem(icon: Icons.settings),
      BottomBarWithSheetItem(icon: Icons.favorite),
      BottomBarWithSheetItem(icon: Icons.bar_chart_sharp),
    ],
    logoImgPath: 'assets/ifsc/logo.png',
    bottomBarTheme: BottomBarTheme(
      selectedItemTextStyle: TextStyle(color: Color(0xff01a2e4)),
      itemTextStyle: TextStyle(color: Colors.white),
      height: 80,
      heightClosed: 80,
      heightOpened: 500,
      mainButtonPosition: MainButtonPosition.right,
      selectedItemIconColor: Color(0xff01a2e4),
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
      body: const Center(child: Text("Hello Worqwer3 qwer ld")),
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
