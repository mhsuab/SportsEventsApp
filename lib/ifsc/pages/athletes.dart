import 'package:sports/utils/utils.dart';
import 'package:flutter/material.dart';

class Athletes extends BaseSinglePage {
  const Athletes({
    Key? key,
  }) : super(
          key: key,
          appbarTitle: "Athletes",
          // appbarActions: [
          //   AppBarActionIcon(icon: Icons.calendar_month, onPressed: () {}),
          // ],
          page: const Center(child: Text("athletes page")),
        );
}
