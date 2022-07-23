import 'package:provider/provider.dart';
import 'package:sports/ifsc/data/events.dart';
import 'package:sports/ifsc/network.dart';
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

class Event2Result extends StatefulWidget {
  const Event2Result({Key? key}) : super(key: key);

  @override
  State<Event2Result> createState() => _Event2ResultState();
}

class _Event2ResultState extends State<Event2Result> {
  int selectedSeasonIdx = 0;
  int selectedLeagueIdx = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey,
      child: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: [
          Positioned(
            bottom: 0,
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
          ),
          FutureBuilder(
            future: getSeasons(),
            builder: (BuildContext context,
                AsyncSnapshot<List<SeasonsInfo>> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.done:
                  return EventsDropdown(items: snapshot.data!);
                default:
                  return const Center(child: Text("pending"));
              }
            },
          ),
        ],
      ),
    );
  }
}

class EventsDropdown extends StatefulWidget {
  final List<SeasonsInfo> items;
  final Function(int)? onSeasonTap;
  final Function(int)? onLeagueTap;

  const EventsDropdown({
    Key? key,
    required this.items,
    this.onSeasonTap,
    this.onLeagueTap,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EventsDropdownState();
}

class _EventsDropdownState extends State<EventsDropdown> {
  bool _isSeasonOpen = false;
  bool _isLeagueOpen = false;
  int _selectedSeasonIdx = 0;
  int _selectedLeagueIdx = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _isSeasonOpen
            ? DropdownMenu<SeasonsInfo>(
                items: widget.items,
                onTap: (idx) {
                  widget.onSeasonTap?.call(idx);
                  setState(() => _selectedSeasonIdx = idx);
                  setState(() => _selectedLeagueIdx = 0);
                  setState(() => _isSeasonOpen = false);
                },
              )
            : DropdownSelected(
                onTap: () {
                  if (!_isLeagueOpen) {
                    setState(() => _isSeasonOpen = true);
                  }
                },
                text: widget.items[_selectedSeasonIdx].toString(),
              ),
        Expanded(
          child: _isLeagueOpen
              ? DropdownMenu<LeagueInfo>(
                  items: <LeagueInfo>[
                    ...widget.items[_selectedSeasonIdx].leagues
                  ],
                  onTap: (idx) {
                    widget.onLeagueTap?.call(idx);
                    setState(() => _selectedLeagueIdx = idx);
                    setState(() => _isLeagueOpen = false);
                  },
                )
              : DropdownSelected(
                  onTap: () {
                    if (!_isSeasonOpen) {
                      setState(() => _isLeagueOpen = true);
                    }
                  },
                  text: widget
                      .items[_selectedSeasonIdx].leagues[_selectedLeagueIdx]
                      .toString(),
                ),
        ),
      ],
    );
  }
}
