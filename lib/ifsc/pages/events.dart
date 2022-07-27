import 'dart:ui';

import 'package:sports/ifsc/data/events.dart';
import 'package:sports/ifsc/network.dart';
import 'package:flutter/material.dart';
import 'package:sports/utils/utils.dart';

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
          child: IgnorePointer(
            ignoring: _isLoading,
            child: Container(
              padding: const EdgeInsets.only(top: 10),
              child: EventList(
                events: events,
              ),
            ),
          ),
        ),
        AnimatedOpacity(
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
