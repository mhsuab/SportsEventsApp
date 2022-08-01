import 'package:flutter/material.dart';
import 'package:sports/utils/utils.dart';

class RadioList<T> extends StatelessWidget {
  final T selected;
  final List<T> items;
  final Function(T?)? toggle;

  RadioList({
    Key? key,
    T? selected,
    required this.items,
    this.toggle,
  })  : assert(items.isNotEmpty),
        selected = selected ?? items.first,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      height: headerSize,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: items
            .map(
              (item) => Expanded(
                child: CustomRadio<T>(
                  value: item,
                  groupValue: selected,
                  onChanged: (value) => toggle?.call(value),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class CustomRadio<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final Function(T)? onChanged;
  final bool checked;

  const CustomRadio({
    Key? key,
    required this.value,
    required this.groupValue,
    this.onChanged,
  })  : checked = (value == groupValue),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final checkedColor = Theme.of(context).colorScheme.primary;
    const uncheckedColor = Colors.black45;

    return InkWell(
      splashColor: Colors.transparent,
      onTap: () => onChanged?.call(value),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: headerSize,
              ),
              Container(
                width: .5 * headerSize,
                height: .5 * headerSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: checked ? checkedColor : uncheckedColor,
                ),
              ),
              Container(
                width: .4 * headerSize,
                height: .4 * headerSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
              ),
              if (value == groupValue)
                Container(
                  width: .3 * headerSize,
                  height: .3 * headerSize,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: checkedColor),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              value.toString(),
              style: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .copyWith(color: checked ? checkedColor : uncheckedColor),
            ),
          ),
        ],
      ),
    );
  }
}
