import 'package:flutter/material.dart';
import 'package:sports/home.dart';
import 'package:sports/sports.dart';
import 'package:sports/utils/page_manager.dart';
import 'package:sports/utils/utils.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with TickerProviderStateMixin {
  SportSwitch? _currentSport;
  final PageManager _pageManager = PageManager();

  void _sportClick(SportSwitch selectedSport) {
    setState(() => _currentSport = selectedSport);
    debugPrint(_currentSport?.name);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      firstCurve: Curves.easeInOut,
      secondCurve: Curves.easeInOut,
      sizeCurve: Curves.easeInOut,
      layoutBuilder: (topChild, topChildKey, bottomChild, bottomChildKey) =>
          Stack(
        alignment: Alignment.topCenter,
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            key: bottomChildKey,
            child: bottomChild,
          ),
          Positioned.fill(
            key: topChildKey,
            child: topChild,
          ),
        ],
      ),
      alignment: Alignment.topCenter,
      firstChild: HomePage(
        onTap: (selectedSport) => _sportClick(selectedSport),
      ),
      secondChild: const SportsApp(),
      crossFadeState: (_currentSport == null)
          ? CrossFadeState.showFirst
          : CrossFadeState.showSecond,
      duration: const Duration(milliseconds: 500),
    );
  }
}
