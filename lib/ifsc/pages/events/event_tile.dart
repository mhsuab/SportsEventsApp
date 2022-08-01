import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sports/ifsc/pages/pages.dart';
import 'package:sports/utils/list/list_item.dart';
import 'package:sports/utils/utils.dart';

import 'package:sports/ifsc/data/events.dart';

import 'event_tags.dart';

class EventTile extends StatelessWidget {
  final Events event;
  const EventTile({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListItem(
      onTap: event.isEvents()
          ? () => Provider.of<PageManager>(context, listen: false).push(
                MaterialPage(
                  child: EventResultsPage(
                    events: event,
                  ),
                ),
              )
          : null,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                event.display,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(event.toLocalDateString()),
            ],
          ),
          EventTags(tags: event.disciplines),
        ],
      ),
    );
  }
}
