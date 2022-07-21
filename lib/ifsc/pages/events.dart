import 'package:provider/provider.dart';
import 'package:sports/ifsc/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:sports/utils/utils.dart';

class EventPage extends BaseSinglePage {
  EventPage({
    Key? key,
  }) : super(
          key: key,
          appbarTitle: "Events",
          appbarActions: [
            AppBarActionIcon(icon: Icons.calendar_month, onPressed: () {}),
          ],
          page: const Event2Result(),
        );
}

class Event2Result extends StatelessWidget {
  const Event2Result({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Provider.of<PageManager>(context, listen: false).push(
            MaterialPage(
              child: Ranking(
                title: "trying...",
              ),
            ),
          );
        },
        child: const Text("Salt Lake City"),
      ),
    );
  }
}
