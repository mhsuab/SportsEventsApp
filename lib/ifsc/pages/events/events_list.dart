import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sports/utils/utils.dart';

import 'package:sports/ifsc/data/events.dart';

import 'event_tags.dart';
import 'event_results.dart';
import 'skeletons.dart';

class EventList extends StatelessWidget {
  final List<Widget> events;
  final ScrollPhysics scrollPhysics;

  EventList({
    Key? key,
    required bool isLoading,
    List<Events>? events,
    ScrollPhysics? scrollPhysics,
  })  : scrollPhysics = (events == null || isLoading)
            ? const NeverScrollableScrollPhysics()
            : const ScrollPhysics(),
        events = (events == null || isLoading)
            ? List.generate(8, (index) => const EventTileSkeleton())
            : List.generate(
                events.length, (index) => EventTile(event: events[index])),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 2.5),
      child: ListView.builder(
        physics: scrollPhysics,
        shrinkWrap: true,
        controller: ScrollController(keepScrollOffset: false),
        primary: false,
        itemCount: events.length,
        itemBuilder: (_, index) => events[index],
      ),
    );
  }
}

class EventTile extends StatelessWidget {
  final Events event;
  const EventTile({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
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
      ),
      child: InkWell(
        customBorder: const BeveledRectangleBorder(
          borderRadius: BorderRadius.horizontal(
            left: Radius.circular(5),
          ),
        ),
        onTap: () {
          if (event.isEvents()) {
            Provider.of<PageManager>(context, listen: false).push(
              MaterialPage(
                child: EventResultsPage(
                  events: event,
                ),
              ),
            );
          }
        },
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
                      event.display,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(event.toLocalDateString()),
                  ],
                ),
                EventTags(tags: event.disciplines),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
