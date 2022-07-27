import 'dart:math';

import 'package:flutter/material.dart';

class DropdownMenu<T> extends StatelessWidget {
  final List<T>? items;
  final Function(int)? onTap;
  final ScrollController controller = ScrollController(keepScrollOffset: false);

  DropdownMenu({
    Key? key,
    this.items,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 3,
          vertical: 2.5,
        ),
        child: Container(
          width: 80,
          height: min(500, 35.0 * (items?.length ?? 0)),
          decoration: ShapeDecoration(
            color: ElevationOverlay.applySurfaceTint(
                Theme.of(context).colorScheme.surface,
                Theme.of(context).colorScheme.surfaceTint,
                1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
          child: Scrollbar(
            controller: controller,
            child: ListView.separated(
              controller: controller,
              separatorBuilder: (context, _) => Divider(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.4),
                height: 1.0,
              ),
              itemCount: (items?.length ?? 0),
              itemBuilder: (context, index) => InkWell(
                onTap: () => onTap?.call(index),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 12,
                  ),
                  child: Text(
                    items?[index].toString() ?? "",
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(color: Theme.of(context).colorScheme.primary),
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}

class DropdownSelected extends StatelessWidget {
  final double? size;
  final Function() onTap;
  final String text;
  final IconData? icon;
  final MainAxisSize mainAxisSize;
  final bool disabled;

  const DropdownSelected({
    Key? key,
    String? text,
    required this.onTap,
    this.size,
    this.icon,
    this.mainAxisSize = MainAxisSize.max,
    bool? disabled,
  })  : text = text ?? "pending",
        disabled = (text == null) ? true : disabled ?? false,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 3,
        vertical: 2.5,
      ),
      child: InkWell(
        onTap: () {
          if (!disabled) onTap.call();
        },
        splashColor: Colors.transparent,
        child: Container(
          width: 80,
          height: size ?? 30.0,
          decoration: ShapeDecoration(
            color: ElevationOverlay.applySurfaceTint(
                Theme.of(context).colorScheme.surface,
                Theme.of(context).colorScheme.surfaceTint,
                1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 12,
              top: 2,
              right: 6,
              bottom: 2,
            ),
            child: disabled
                ? Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      text,
                      // disabled.toString(),
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.5)),
                    ),
                  )
                : Row(
                    mainAxisSize: mainAxisSize,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        text,
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: Theme.of(context).colorScheme.primary),
                      ),
                      Icon(
                        Icons.arrow_drop_down_rounded,
                        color: Theme.of(context).colorScheme.primary,
                      )
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
