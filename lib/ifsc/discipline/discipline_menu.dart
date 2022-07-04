import 'package:flutter/material.dart';
import 'package:sports/ifsc/discipline/discipline_display.dart';

class DisciplineButtonMenu extends StatefulWidget {
  const DisciplineButtonMenu({
    Key? key,
    required this.items,
    this.toggleUpdate,
  }) : super(key: key);

  // items: availavle item to switch between
  final List<Discipline> items;
  final Function(bool, int)? toggleUpdate;

  @override
  State<StatefulWidget> createState() => _DisciplineBottonMenuState();
}

class _DisciplineBottonMenuState extends State<DisciplineButtonMenu> {
  int _selected = 0;
  bool _isFemale = true;
  bool _isOpened = false;

  @override
  void initState() {
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
    return _isOpened
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
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                onPrimary:
                                    Theme.of(context).colorScheme.onPrimary,
                                primary: disciplineMapping[discipline]!.color,
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
                          side: BorderSide(color: Colors.black, width: 0.05)),
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
                    setState(() {
                      _selected = (_selected + 1) % widget.items.length;
                    });
                    widget.toggleUpdate?.call(_isFemale, _selected);
                  },
            onLongPressed: widget.items.length == 1
                ? () {}
                : () {
                    setState(() {
                      _isOpened = true;
                    });
                  },
          );
  }
}
