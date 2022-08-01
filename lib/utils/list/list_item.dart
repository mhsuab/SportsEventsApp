import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class ListItem extends StatelessWidget {
  final Function()? onTap;
  final double? elevation;
  final Widget child;
  final bool isSkeleton;
  const ListItem({
    Key? key,
    this.onTap,
    this.elevation,
    this.isSkeleton = false,
    required this.child,
  })  : assert(!isSkeleton || onTap == null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation ?? 5,
      margin: const EdgeInsets.only(
        left: 5.0,
        top: 0.0,
        right: 0.0,
        bottom: 3.0,
      ),
      shape: const BeveledRectangleBorder(
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(5),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: SizedBox(
          height: 70,
          child: isSkeleton
              ? SkeletonItem(
                  child: child,
                )
              : ((onTap == null)
                  ? Container(
                      child: child,
                    )
                  : InkWell(
                      onTap: onTap,
                      child: child,
                    )),
        ),
      ),
    );
  }
}
