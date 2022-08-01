import 'package:flutter/material.dart';

class ListDisplay<T> extends StatelessWidget {
  final List<Widget> items;
  final ScrollPhysics scrollPhysics;
  final Widget Function() skeletonListItem;
  final Widget Function(T) listItem;

  ListDisplay({
    Key? key,
    required isLoading,
    required this.skeletonListItem,
    required this.listItem,
    List<T>? items,
    int skeletonLength = 8,
  })  : scrollPhysics = (isLoading)
            ? const NeverScrollableScrollPhysics()
            : const ScrollPhysics(),
        items = (items == null || isLoading)
            ? List.generate(skeletonLength, (_) => skeletonListItem())
            : List.generate(items.length, (index) => listItem(items[index])),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 2.5),
      child: (items.isEmpty)
          ? Center(
              child: Text(
                'No Data...',
                style: Theme.of(context).appBarTheme.titleTextStyle?.copyWith(
                      letterSpacing: 8.0,
                      fontStyle: FontStyle.italic,
                      color: Colors.black38,
                    ),
              ),
            )
          : ListView.builder(
              physics: scrollPhysics,
              shrinkWrap: true,
              controller: ScrollController(keepScrollOffset: false),
              primary: false,
              itemCount: items.length,
              itemBuilder: (_, index) => items[index],
            ),
    );
  }
}
