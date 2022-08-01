import 'package:flutter/material.dart';

import 'package:sports/ifsc/data/data.dart';
import 'package:sports/ifsc/data/discipline/boulder.dart';
import 'package:sports/ifsc/pages/pages.dart';

import 'package:sports/utils/radio_list.dart';
import 'package:sports/utils/utils.dart';

import 'ranking_tile.dart';

class EventResultsPage extends BaseSinglePage {
  EventResultsPage({
    Key? key,
    Events? events,
  }) : super(
          key: key,
          appbarTitle: events?.name.split(' (')[0],
          page: EventResults(events: events ?? Events.dummy()),
        );
}

class EventResults extends StatefulWidget {
  final Events events;
  const EventResults({
    Key? key,
    required this.events,
  }) : super(key: key);

  @override
  State<EventResults> createState() => _EventResultsState();
}

class _EventResultsState extends State<EventResults> {
  final DisciplineTypeNWidgets ddd = resultMapping[Discipline.boulder]!;
  bool _isLoading = true;
  AthleteList? _athletes;
  String _catName = "all";
  String content = "InitState";
  Event? _round;

  @override
  void initState() {
    toggleDiscipline(true, 0);
    super.initState();
  }

  void toggleDiscipline(bool isFemale, int selected) {
    setState(() => _isLoading = true);
    setState(() => _round =
        widget.events.getRound(isFemale, widget.events.disciplines[selected]));
    if (_round != null) {
      ddd.getGeneralRanking(_round!.resultUrl).then((value) {
        setState(() => _athletes = ddd.getAthleteList(value));
      });
    }
    setState(() => _isLoading = false);
  }

  void toggleRadio(String? value) {
    if (value != _catName) setState(() => _catName = value ?? "all");
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned.fill(
          top: headerSize,
          child: IgnorePointer(
            ignoring: _isLoading,
            child: Container(
              padding: const EdgeInsets.only(top: 10),
              child: ListDisplay<BoulderAthlete>(
                isLoading: _isLoading,
                skeletonListItem: () => const RankingTile(
                  rank: 1,
                  country: 'JPN',
                  roundStatus: RoundPart.semifinalist,
                ),
                listItem: (a) => const RankingTile(
                  rank: 1,
                  country: 'JPN',
                  roundStatus: RoundPart.finalist,
                ),
                // items: [],
                skeletonLength: 9,
              ),
            ),
          ),
        ),
        Center(
          child: Text(_catName),
        ),
        Positioned(
          top: 0,
          child: RadioList<String>(
            selected: _catName,
            items: const ['all', 'final', 'semi', 'qual'],
            toggle: toggleRadio,
          ),
        ),
        // if (_round?.discipline == Discipline.boulder)
        //   Positioned(
        //     top: headerSize,
        //     child: ddd.resultGeneralWidget(
        //       _athletes?.ranking(_catName),
        //     ),
        //   ),

        Positioned(
          left: 10,
          bottom: 10,
          child: DisciplineButtonMenu(
            toggleUpdate: (isFemale, selected) =>
                toggleDiscipline(isFemale, selected),
            items: widget.events.disciplines,
          ),
        ),
      ],
    );
  }
}
