import 'package:flutter/material.dart';
import 'package:sports/utils/base_single_page.dart';

import 'package:sports/ifsc/data/events.dart';

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

class EventResults extends StatelessWidget {
  final Events events;
  const EventResults({
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
