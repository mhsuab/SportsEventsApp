import 'dart:ui';

import 'package:sports/ifsc/network.dart';
import 'package:flutter/material.dart';
import 'package:sports/ifsc/pages/events/skeletons.dart';
import 'package:sports/utils/utils.dart';

import 'package:sports/ifsc/data/events.dart';

import 'events_dropdown.dart';
import 'event_tile.dart';

class EventPage extends BaseSinglePage {
  const EventPage({
    Key? key,
  }) : super(
          key: key,
          appbarTitle: "Events",
          page: const EventsResult(),
        );
}

class EventsResult extends StatefulWidget {
  const EventsResult({Key? key}) : super(key: key);

  @override
  State<EventsResult> createState() => _EventsResultState();
}

class _EventsResultState extends State<EventsResult> {
  List<SeasonsInfo>? items;
  List<Events>? events;
  bool _isLoading = true;
  bool _isIgnored = true;

  @override
  void initState() {
    getIfscData<SeasonsInfo>('/api/v1', 'seasons', SeasonsInfo.fromJson)
        .then((value) {
      setState(() => items = value);
      toggleLoad(items![0].leagues[0].url);
      setState(() => _isLoading = false);
      endIgnored();
    });
    super.initState();
  }

  void startIgnored() => setState(() => _isIgnored = true);
  void endIgnored() => setState(() => _isIgnored = false);

  void toggleLoad(String url) async {
    setState(() => _isLoading = true);
    setState(() => events?.clear());
    final List<Events> result =
        await getIfscData(url, 'events', Events.fromJson);
    setState(() => events = result);
    setState(() => _isLoading = false);
  }

  Widget getSkeleton() => const EventTileSkeleton();
  Widget getListItem(Events event) => EventTile(event: event);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      fit: StackFit.expand,
      children: [
        Positioned.fill(
          top: headerSize,
          child: IgnorePointer(
            ignoring: _isIgnored,
            child: Container(
              padding: const EdgeInsets.only(top: 10),
              child: ListDisplay<Events>(
                isLoading: _isLoading,
                skeletonListItem: getSkeleton,
                listItem: getListItem,
                items: events,
                skeletonLength: 9,
              ),
            ),
          ),
        ),
        AnimatedOpacity(
          opacity: _isIgnored ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 500),
          curve: Curves.fastLinearToSlowEaseIn,
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 5.0,
              sigmaY: 5.0,
            ),
            child: const SizedBox.shrink(),
          ),
        ),
        EventsDropdown(
          items: items,
          size: headerSize,
          initSeasonIdx: 0,
          initLeagueIdx: 0,
          toggle: toggleLoad,
          tapOpen: startIgnored,
          tapClose: endIgnored,
        ),
      ],
    );
  }
}
