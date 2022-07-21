library bottom_bar_button;

import 'package:flutter/material.dart';
import 'package:sports/utils/utils.dart';

class BottomBarButton extends StatelessWidget {
  final Function() onTap;
  final Widget _button;
  final bool disabled;
  final Color _splash;

  BottomBarButton({
    Key? key,
    required this.onTap,
    required String buttonImage,
    this.disabled = false,
    Widget? button,
    Color? splash,
  })  : _button = button ??
            SizedBox(
              width: bottomTileHeight * 0.6,
              height: bottomTileHeight * 0.6,
              child: Image.asset(buttonImage),
            ),
        _splash = Colors.black12,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5.0),
      height: bottomTileHeight * 0.8,
      child: disabled
          ? _button
          : Material(
              color: Colors.transparent,
              child: InkWell(
                customBorder: const CircleBorder(),
                splashColor: _splash,
                onTap: onTap,
                child: _button,
              ),
            ),
    );
  }
}
