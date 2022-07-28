import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sports/home.dart';
import 'package:sports/sports.dart';
import 'package:sports/utils/utils.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Widget display;

  void setToSports(SportSwitch selectedSport) =>
      display = ChangeNotifierProvider(
        create: (context) => PageManager(selectedSport: selectedSport),
        child: const SportsApp(),
      );
  void setToHome() => display = HomePage(
        onTap: (selectedSport) => _sportClick(selectedSport),
      );

  void _sportClick(SportSwitch selectedSport) {
    setState(() => setToSports(selectedSport));
  }

  @override
  void initState() {
    if (sports.length == 1) {
      setToSports(sports.keys.first);
    } else {
      setToHome();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      switchInCurve: Curves.fastLinearToSlowEaseIn,
      switchOutCurve: Curves.ease,
      duration: animationDuration,
      child: display,
    );
  }
}
