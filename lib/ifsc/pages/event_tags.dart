import 'package:flutter/material.dart';
import 'package:sports/ifsc/discipline/discipline_display.dart';

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
