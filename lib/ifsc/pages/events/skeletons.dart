import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';
import 'package:sports/utils/list/list.dart';

class EventTileSkeleton extends StatelessWidget {
  const EventTileSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListItem(
      isSkeleton: true,
      elevation: 3,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              SkeletonLine(
                style: SkeletonLineStyle(
                  width: 260,
                  height: 20,
                ),
              ),
              SkeletonLine(
                style: SkeletonLineStyle(
                  width: 245,
                  height: 14,
                ),
              ),
            ],
          ),
          const EventTagsSkeleton(),
        ],
      ),
    );
  }
}

class EventTagsSkeleton extends StatelessWidget {
  const EventTagsSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 1.0,
        horizontal: 10.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(
          4,
          (_) => const EventTagSkeleton(),
        ),
      ),
    );
  }
}

class EventTagSkeleton extends StatelessWidget {
  const EventTagSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SkeletonItem(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0.5),
        child: Transform(
          alignment: Alignment.bottomLeft,
          transform: Matrix4.skewX(-0.5),
          child: SkeletonItem(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Container(
                  width: 70,
                  height: 16,
                  decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
