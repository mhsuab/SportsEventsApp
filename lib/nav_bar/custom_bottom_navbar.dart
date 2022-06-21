import 'package:bottom_bar_with_sheet/bottom_bar_with_sheet.dart';

class CustomBottomNavBar {
  const CustomBottomNavBar({
    required this.items,
    required this.logoImgPath,
    this.bottomBarTheme = defaultBarTheme,
  });

  final List<BottomBarWithSheetItem> items;
  final String logoImgPath;
  final BottomBarTheme bottomBarTheme;
}
