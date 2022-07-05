import 'package:flutter/material.dart';
import 'package:sports/utils/base_single_page.dart';

import 'package:sports/ifsc/discipline/discipline.dart';
import 'package:sports/ifsc/pages/pages.dart';

class Ranking extends BaseSinglePage {
  final String title;

  Ranking({
    Key? key,
    required this.title,
  }) : super(
            key: key,
            appbarTitle: title,
            appbarActions: [
              AppBarActionIcon(icon: Icons.link, onPressed: () {}),
            ],
            page: const ResultPage(items: <Discipline>[
              Discipline.combined,
              Discipline.boulder,
              Discipline.lead,
              Discipline.speed,
            ]));
}

class ResultPage extends StatefulWidget {
  const ResultPage({
    Key? key,
    required this.items,
  }) : super(key: key);

  final List<Discipline> items;

  @override
  State<StatefulWidget> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
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
            color: Theme.of(context).primaryColor, //.withAlpha(200),
          ),
          Positioned(
              top: 100,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) => EventPage())));
                },
                child: const Text("pushed"),
              )),
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
