import 'package:flutter/material.dart';
import 'package:sports/utils/utils.dart';
import 'package:sports/ifsc/data/events.dart';

class EventsDropdown extends StatefulWidget {
  final int initSeasonIdx;
  final int initLeagueIdx;
  final double? size;
  final List<SeasonsInfo>? items;
  final Function(int)? onSeasonTap;
  final Function(int)? onLeagueTap;
  final Function()? closeDropdown;
  final Function(String)? toggle;
  final Function()? tapOpen;
  final Function()? tapClose;

  const EventsDropdown({
    Key? key,
    required this.items,
    this.initSeasonIdx = 0,
    this.initLeagueIdx = 0,
    this.size,
    this.onSeasonTap,
    this.onLeagueTap,
    this.closeDropdown,
    this.toggle,
    this.tapOpen,
    this.tapClose,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EventsDropdownState();
}

class _EventsDropdownState extends State<EventsDropdown> {
  bool _isSeasonOpen = false;
  bool _isLeagueOpen = false;
  late int _selectedSeasonIdx;
  late int _selectedLeagueIdx;

  @override
  void initState() {
    _selectedSeasonIdx = widget.initSeasonIdx;
    _selectedLeagueIdx = widget.initLeagueIdx;
    super.initState();
  }

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
                  if (_selectedSeasonIdx != idx) {
                    widget.onSeasonTap?.call(idx);
                    setState(() => _selectedSeasonIdx = idx);
                    setState(() => _selectedLeagueIdx = widget.initLeagueIdx);
                    widget.toggle?.call(
                      widget.items![_selectedSeasonIdx]
                          .leagues[_selectedLeagueIdx].url,
                    );
                  }
                  setState(() => _isSeasonOpen = false);
                  widget.tapClose?.call();
                },
              )
            : DropdownSelected(
                size: widget.size,
                onTap: () {
                  if (!_isLeagueOpen) {
                    setState(() => _isSeasonOpen = true);
                    widget.tapOpen?.call();
                  }
                },
                text: widget.items?[_selectedSeasonIdx].toString(),
              ),
        Expanded(
          child: _isLeagueOpen
              ? DropdownMenu<LeagueInfo>(
                  items: <LeagueInfo>[
                    ...?widget.items?[_selectedSeasonIdx].leagues
                  ],
                  onTap: (idx) {
                    if (_selectedLeagueIdx != idx) {
                      widget.onLeagueTap?.call(idx);
                      setState(() => _selectedLeagueIdx = idx);
                      setState(() => _isLeagueOpen = false);
                      widget.toggle?.call(
                        widget.items![_selectedSeasonIdx]
                            .leagues[_selectedLeagueIdx].url,
                      );
                    }
                    setState(() => _isLeagueOpen = false);
                    widget.tapClose?.call();
                  },
                )
              : DropdownSelected(
                  size: widget.size,
                  onTap: () {
                    if (!_isSeasonOpen) {
                      setState(() => _isLeagueOpen = true);
                      widget.tapOpen?.call();
                    }
                  },
                  text: widget
                      .items?[_selectedSeasonIdx].leagues[_selectedLeagueIdx]
                      .toString(),
                ),
        ),
      ],
    );
  }
}
