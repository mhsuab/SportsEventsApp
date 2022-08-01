import 'package:flutter/material.dart';

import 'discipline_display.dart';

class DisciplineButtonMenu extends StatefulWidget {
  const DisciplineButtonMenu({
    Key? key,
    required this.items,
    this.initIsFemale,
    this.initSelected,
    this.toggleUpdate,
  }) : super(key: key);

  final bool? initIsFemale;
  final int? initSelected;
  // items: availavle item to switch between
  final List<Discipline> items;
  final Function(bool, int)? toggleUpdate;

  @override
  State<StatefulWidget> createState() => _DisciplineBottonMenuState();
}

class _DisciplineBottonMenuState extends State<DisciplineButtonMenu> {
  late int _selected;
  late bool _isFemale;
  bool _isOpened = false;

  @override
  void initState() {
    setState(() => _isFemale = widget.initIsFemale ?? true);
    setState(() => _selected = widget.initSelected ?? 0);
    super.initState();
  }

  void _onPressedMenu(int idx) {
    setState(() {
      _selected = idx;
      _isOpened = false;
    });
    widget.toggleUpdate?.call(_isFemale, _selected);
  }

  @override
  Widget build(BuildContext context) {
    return (widget.items.isEmpty)
        ? const SizedBox.shrink()
        : _isOpened
            ? Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    ...widget.items
                        .asMap()
                        .map((idx, discipline) => MapEntry(
                            idx,
                            ElevatedButton(
                                onPressed: () => _onPressedMenu(idx),
                                style: ElevatedButton.styleFrom(
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    onPrimary:
                                        Theme.of(context).colorScheme.onPrimary,
                                    primary:
                                        disciplineMapping[discipline]!.color,
                                    fixedSize: const Size(150, 40),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                          topLeft: idx == 0
                                              ? const Radius.circular(10.0)
                                              : Radius.zero,
                                          topRight: idx == 0
                                              ? const Radius.circular(10.0)
                                              : Radius.zero,
                                        ),
                                        side: const BorderSide(
                                            color: Colors.white, width: 0.15))),
                                child: Text(
                                  disciplineMapping[discipline]!.name,
                                ))))
                        .values
                        .toList(),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          onPrimary: Colors.black54,
                          primary: Colors.white,
                          fixedSize: const Size(150, 40),
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10.0),
                                bottomRight: Radius.circular(10.0),
                              ),
                              side:
                                  BorderSide(color: Colors.black, width: 0.05)),
                        ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
                        onPressed: () => setState(() => _isOpened = false),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const <Widget>[
                            Icon(
                              Icons.reply,
                              size: 14,
                            ),
                            Text("Cancel"),
                            SizedBox(
                              width: 14,
                            ),
                          ],
                        )),
                  ])
            : DisciplineDisplay(
                isFemale: _isFemale,
                selected: widget.items[_selected],
                onGenderPressed: () {
                  setState(() {
                    _isFemale = !_isFemale;
                  });
                  widget.toggleUpdate?.call(_isFemale, _selected);
                },
                onPressed: widget.items.length == 1
                    ? () {}
                    : () {
                        setState(() =>
                            _selected = (_selected + 1) % widget.items.length);
                        widget.toggleUpdate?.call(_isFemale, _selected);
                      },
                onLongPressed: widget.items.length == 1
                    ? () {
                        setState(() => _isOpened = true);
                      }
                    : () {
                        setState(() => _isOpened = true);
                      },
              );
  }
}
