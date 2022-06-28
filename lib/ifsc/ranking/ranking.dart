import 'package:flutter/material.dart';

import 'package:sports/ifsc/discipline/discipline.dart';

class RankingPage extends StatefulWidget {
  RankingPage({
    Key? key,
    required this.items,
  }) : super(key: key);

  final List<Discipline> items;

  @override
  State<StatefulWidget> createState() => _RankingPageState();
}

class _RankingPageState extends State<RankingPage> {
  String content = "InitState";

  void toggleUpdate(bool isFemale, int selected) {
    setState(() {
      content =
          "${isFemale ? 'Female' : 'Male'} ${disciplineMapping[widget.items[selected]]!.name}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints.expand(),
      child: Stack(
        alignment: Alignment.center, //指定未定位或部分定位widget的对齐方式
        children: <Widget>[
          Container(
            color: Colors.cyan,
          ),
          Container(
            color: Colors.red,
            child: Text(content),
          ),
          Positioned(
            left: 10,
            bottom: 10,
            child: DisciplineButtonMenu(
              toggleUpdate: (isFemale, selected) =>
                  toggleUpdate(isFemale, selected),
              items: widget.items,
            ),
          ),
        ],
      ),
    );
  }
}
