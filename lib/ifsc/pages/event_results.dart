import 'package:flutter/material.dart';
import 'package:sports/ifsc/data/events.dart';
import 'package:sports/ifsc/discipline/discipline.dart';
import 'package:sports/utils/base_single_page.dart';

class EventResultsPage extends BaseSinglePage {
  EventResultsPage({
    Key? key,
    Events? events,
  }) : super(
          key: key,
          appbarTitle: events?.name.split(' ')[0],
          page: EventPage(events: events ?? Events.dummy()),
        );
}

class EventPage extends StatelessWidget {
  final Events events;
  const EventPage({
    Key? key,
    required this.events,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        events.toLocalDateString(),
      ),
    );
  }
}
