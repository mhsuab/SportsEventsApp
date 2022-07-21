import 'package:flutter/material.dart';
import 'package:sports/utils/utils.dart';

enum TransitionType { iosSwipe, bottom2topJoined, fadeIn }

class CustomPage<T> extends Page<T> {
  const CustomPage({
    LocalKey? key,
    String? name,
    Object? arguments,
    String? restorationId,
    Duration? duration,
    this.type,
    required this.child,
  })  : _duration = duration ??
            ((type == TransitionType.bottom2topJoined ||
                    type == TransitionType.fadeIn)
                ? animationDuration
                : const Duration(milliseconds: 200)),
        super(
          key: key,
          name: name,
          arguments: arguments,
          restorationId: restorationId,
        );

  final Duration _duration;
  final Widget child;
  final TransitionType? type;

  Widget _transition(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    switch (type) {
      case TransitionType.bottom2topJoined:
        return SlideTransition(
          position: Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
              .animate(CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOut,
          )),
          child: child,
        );
      case TransitionType.fadeIn:
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      case TransitionType.iosSwipe:
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      default:
        return child;
    }
  }

  @override
  Route<T> createRoute(BuildContext context) {
    return PageRouteBuilder(
      settings: this,
      pageBuilder: ((context, animation, secondaryAnimation) => child),
      transitionDuration: _duration,
      transitionsBuilder: ((context, animation, secondaryAnimation, child) =>
          _transition(context, animation, secondaryAnimation, child)),
    );
  }

  @override
  String toString() {
    return "($child, $name)";
  }
}
