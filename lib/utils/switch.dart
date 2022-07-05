import 'package:flutter/material.dart';
import 'package:sports/ifsc/ifsc.dart';
import 'package:sports/utils/utils.dart';

Map<SportSwitch, SportData> sports = {
  SportSwitch.ifsc: ifsc,
  SportSwitch.wimbledon: wimbledon,
};

SportData wimbledon = SportData(
  theme: wimbledonTheme,
  logo: 'assets/wimbledon.png',
  items: [
    const SportTab(
      icon: Icons.add_box,
      label: 'add',
      page: Center(child: Text("add")),
    ),
    const SportTab(
      icon: Icons.qr_code,
      label: 'scan',
      page: Center(child: Text("scan")),
    ),
    const SportTab(
      icon: Icons.event,
      label: 'events',
      page: Center(child: Text("wimbledon")),
    ),
  ],
  background: Colors.lightGreen,
  icon: Colors.white,
  text: Colors.white,
  selectedIcon: const Color.fromARGB(255, 69, 222, 233),
  selectedText: const Color.fromARGB(255, 228, 122, 1),
  splash: const Color.fromARGB(255, 1, 228, 43),
);
