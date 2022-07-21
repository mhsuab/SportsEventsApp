import 'package:flutter/material.dart';
import 'package:sports/utils/utils.dart';

class PageManager extends ChangeNotifier {
  final Map<SportSwitch, List<List<Page>>> allPages = sports.map(
      (key, value) => MapEntry(key, value.items.map((e) => [e.page]).toList()));
  SportSwitch _currentSport;
  int _currentIndex;
  bool _isOpened = false;

  bool get isOpened => _isOpened;
  SportData get data => sports[_currentSport]!;
  SportTab get tab => sports[_currentSport]!.items[_currentIndex];
  List<Page> get pages =>
      List.unmodifiable(allPages[_currentSport]![_currentIndex]);
  List<Page> get _localPages => allPages[_currentSport]![_currentIndex];

  bool isSelected(int index) => index == _currentIndex;

  PageManager({
    required SportSwitch selectedSport,
    int selectedIndex = 0,
  })  : _currentIndex = selectedIndex,
        _currentSport = selectedSport;

  void openBar() {
    _isOpened = true;
    notifyListeners();
  }

  void toggleBar() {
    _isOpened = !_isOpened;
    notifyListeners();
  }

  void resetPages() {
    for (var element in allPages[_currentSport]!) {
      element.removeRange(1, element.length);
    }
  }

  void changeSport(SportSwitch selectedSport) {
    if (selectedSport == _currentSport) return;
    resetPages();
    _currentSport = selectedSport;
    _currentIndex = 0;
    _isOpened = false;
    notifyListeners();
  }

  void changeTab(int selectedIndex) {
    if (selectedIndex == _currentIndex) {
      _localPages.removeRange(1, _localPages.length);
    } else {
      _currentIndex = selectedIndex;
    }
    notifyListeners();
  }

  void push(Page page) {
    _localPages.add(page);
    notifyListeners();
  }

  void pop() {
    _localPages.removeLast();
    notifyListeners();
  }
}
