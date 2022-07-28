import 'dart:ui';

import 'package:skeletons/skeletons.dart';
import 'package:sports/ifsc/network.dart';
import 'package:flutter/material.dart';
import 'package:sports/utils/utils.dart';

import 'package:sports/ifsc/data/events.dart';

import 'events_dropdown.dart';
import 'events_list.dart';

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
  final double dropdownSize = 30.0;
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
    final List<Events>? result =
        await getIfscData(url, 'events', Events.fromJson);
    setState(() => events = result);
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      fit: StackFit.expand,
      children: [
        Positioned.fill(
          top: dropdownSize,
          child: IgnorePointer(
            ignoring: _isIgnored,
            child: Container(
              padding: const EdgeInsets.only(top: 10),
              child: EventList(
                events: events,
                isLoading: _isLoading,
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
          size: dropdownSize,
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
