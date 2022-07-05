import 'package:flutter/material.dart';

abstract class BaseSinglePage extends StatelessWidget {
  final AppBar? appbar;
  final String? appbarTitle;
  final List<Widget>? appbarActions;
  final Widget page;

  const BaseSinglePage({
    Key? key,
    this.appbar,
    this.appbarTitle,
    this.appbarActions,
    required this.page,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (appbar == null && appbarTitle == null && appbarActions == null)
        ? page
        : Scaffold(
            appBar: appbar ??
                AppBar(
                  title: Text(appbarTitle ?? ""),
                  actions: appbarActions,
                  centerTitle: true,
                  titleSpacing: 10,
                ),
            body: page,
          );
  }
}

class AppBarActionIcon extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const AppBarActionIcon({
    Key? key,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: onPressed,
        icon: Icon(icon),
        splashRadius:
            0.5 * (Theme.of(context).appBarTheme.actionsIconTheme?.size ?? 24));
  }
}
