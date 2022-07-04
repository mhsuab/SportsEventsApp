import 'package:sports/base_single_page.dart';
import 'package:sports/ifsc/pages/pages.dart';
import 'package:flutter/material.dart';

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
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => Ranking(title: "title")));
        // Navigator.of(context).push(
        //     context,
        //     MaterialPageRoute(
        //         builder: ((context) => Ranking(
        //               title: "Salt Lake City",
        //             ))));
      },
      child: const Text("Salt Lake City"),
    ));
  }
}
