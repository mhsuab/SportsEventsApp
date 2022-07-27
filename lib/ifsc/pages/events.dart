import 'dart:ui';

import 'package:provider/provider.dart';
import 'package:sports/ifsc/data/events.dart';
import 'package:sports/ifsc/discipline/discipline.dart';
import 'package:sports/ifsc/network.dart';
import 'package:flutter/material.dart';
import 'package:sports/ifsc/pages/event_results.dart';
import 'package:sports/ifsc/pages/live_result.dart';
import 'package:sports/utils/utils.dart';

import 'pages.dart';

class EventPage extends BaseSinglePage {
  const EventPage({
    Key? key,
  }) : super(
          key: key,
          appbarTitle: "Events",
          page: const Event2Result(),
        );
}

class Event2Result extends StatefulWidget {
  const Event2Result({Key? key}) : super(key: key);

  @override
  State<Event2Result> createState() => _Event2ResultState();
}

class _Event2ResultState extends State<Event2Result> {
  final double dropdownSize = 30.0;
  List<SeasonsInfo>? items;
  List<Events>? events;
  bool _isLoading = true;

  @override
  void initState() {
    getIfscData<SeasonsInfo>('/api/v1', 'seasons', SeasonsInfo.fromJson)
        .then((value) {
      setState(() => items = value);
      toggleLoading(items![0].leagues[0].url);
      endLoading();
    });
    super.initState();
  }

  void startLoading() => setState(() => _isLoading = true);
  void endLoading() => setState(() => _isLoading = false);
  void toggleLoading(String url) async {
    if (events != null) setState(() => events!.clear());
    final List<Events>? result =
        await getIfscData(url, 'events', Events.fromJson);
    setState(() => events = result);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      fit: StackFit.expand,
      children: [
        Positioned.fill(
          top: dropdownSize,
          child: Container(
            padding: const EdgeInsets.only(top: 10),
            child: EventList(
              events: events,
            ),
          ),
        ),
        IgnorePointer(
          ignoring: _isLoading,
          child: AnimatedOpacity(
            opacity: _isLoading ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 500),
            curve: Curves.fastLinearToSlowEaseIn,
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 5.0,
                sigmaY: 5.0,
              ),
              child: const SpinKitFadingCircle(),
            ),
          ),
        ),
        EventsDropdown(
          items: items,
          size: dropdownSize,
          initSeasonIdx: 0,
          initLeagueIdx: 0,
          toggle: toggleLoading,
          tapOpen: startLoading,
          tapClose: endLoading,
        ),
      ],
    );
  }
}

class EventsDropdown extends StatefulWidget {
  final int initSeasonIdx;
  final int initLeagueIdx;
  final double? size;
  final List<SeasonsInfo>? items;
  final Function(int)? onSeasonTap;
  final Function(int)? onLeagueTap;
  final Function(String)? toggle;
  final Function()? tapOpen;
  final Function()? tapClose;

  const EventsDropdown({
    Key? key,
    required this.items,
    this.initSeasonIdx = 0,
    this.initLeagueIdx = 0,
    this.size,
    this.onSeasonTap,
    this.onLeagueTap,
    this.toggle,
    this.tapOpen,
    this.tapClose,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EventsDropdownState();
}

class _EventsDropdownState extends State<EventsDropdown> {
  bool _isSeasonOpen = false;
  bool _isLeagueOpen = false;
  late int _selectedSeasonIdx;
  late int _selectedLeagueIdx;

  @override
  void initState() {
    _selectedSeasonIdx = widget.initSeasonIdx;
    _selectedLeagueIdx = widget.initLeagueIdx;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _isSeasonOpen
            ? DropdownMenu<SeasonsInfo>(
                items: widget.items,
                onTap: (idx) {
                  if (_selectedSeasonIdx != idx) {
                    widget.onSeasonTap?.call(idx);
                    setState(() => _selectedSeasonIdx = idx);
                    setState(() => _selectedLeagueIdx = widget.initLeagueIdx);
                    widget.toggle?.call(
                      widget.items![_selectedSeasonIdx]
                          .leagues[_selectedLeagueIdx].url,
                    );
                  }
                  setState(() => _isSeasonOpen = false);
                  widget.tapClose?.call();
                },
              )
            : DropdownSelected(
                size: widget.size,
                onTap: () {
                  if (!_isLeagueOpen) {
                    setState(() => _isSeasonOpen = true);
                    widget.tapOpen?.call();
                  }
                },
                text: widget.items?[_selectedSeasonIdx].toString(),
              ),
        Expanded(
          child: _isLeagueOpen
              ? DropdownMenu<LeagueInfo>(
                  items: <LeagueInfo>[
                    ...?widget.items?[_selectedSeasonIdx].leagues
                  ],
                  onTap: (idx) {
                    if (_selectedLeagueIdx != idx) {
                      widget.onLeagueTap?.call(idx);
                      setState(() => _selectedLeagueIdx = idx);
                      setState(() => _isLeagueOpen = false);
                      widget.toggle?.call(
                        widget.items![_selectedSeasonIdx]
                            .leagues[_selectedLeagueIdx].url,
                      );
                    }
                    setState(() => _isLeagueOpen = false);
                    widget.tapClose?.call();
                  },
                )
              : DropdownSelected(
                  size: widget.size,
                  onTap: () {
                    if (!_isSeasonOpen) {
                      setState(() => _isLeagueOpen = true);
                      widget.tapOpen?.call();
                    }
                  },
                  text: widget
                      .items?[_selectedSeasonIdx].leagues[_selectedLeagueIdx]
                      .toString(),
                ),
        ),
      ],
    );
  }
}

class EventList extends StatelessWidget {
  final List<Events>? events;
  const EventList({
    Key? key,
    this.events,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 2.5),
      child: ListView.builder(
        shrinkWrap: true,
        controller: ScrollController(keepScrollOffset: false),
        primary: false,
        itemCount: events?.length,
        itemBuilder: (context, index) => EventTile(
          event: events?[index],
        ),
      ),
    );
  }
}

class EventTile extends StatelessWidget {
  final Events? event;
  const EventTile({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
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
        // side: BorderSide(
        //   color: Theme.of(context).colorScheme.primary,
        //   style: BorderStyle.solid,
        //   width: .2,
        // ),
      ),
      child: InkWell(
        customBorder: const BeveledRectangleBorder(
          borderRadius: BorderRadius.horizontal(
            left: Radius.circular(5),
          ),
        ),
        onTap: () => Provider.of<PageManager>(context, listen: false).push(
          MaterialPage(
            child: EventResultsPage(
              events: event,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: SizedBox(
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event?.name.toString() ?? "",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(event?.toLocalDateString() ?? ""),
                  ],
                ),
                EventTags(tags: event?.disciplines),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class EventTags extends StatelessWidget {
  final List<Discipline> _tags;
  EventTags({Key? key, List<Discipline>? tags})
      : _tags = tags ?? [],
        super(key: key);

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
        children: _tags
            .map((tag) => EventTag(discipline: disciplineMapping[tag]!))
            .toList(),
      ),
    );
  }
}

class EventTag extends StatelessWidget {
  final DisciplineData discipline;
  const EventTag({Key? key, required this.discipline}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.5),
      child: Transform(
        alignment: Alignment.bottomLeft,
        transform: Matrix4.skewX(-0.5),
        child: Container(
          width: 68,
          padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0),
          color: discipline.color,
          child: Transform(
            transform: Matrix4.skewX(0.5),
            child: Text(
              discipline.name,
              textAlign: TextAlign.end,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
