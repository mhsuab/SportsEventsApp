import 'dart:core';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sports/ifsc/discipline/discipline.dart';

class SeasonsInfo {
  final int id;
  final String url;
  final String name;
  final List<LeagueInfo> leagues;
  SeasonsInfo(this.id, this.url, this.name, this.leagues);

  factory SeasonsInfo.fromJson(Map<String, dynamic> json) {
    return SeasonsInfo(
      json['id'],
      json['url'],
      json['name'],
      json['leagues']
          .map((league) => LeagueInfo.fromJson(league))
          .toList()
          .cast<LeagueInfo>(),
    );
  }

  factory SeasonsInfo.dummy() => SeasonsInfo(-1, "", "", []);

  @override
  String toString() => name;
}

class LeagueInfo {
  final int id;
  final String name;
  final String url;
  LeagueInfo(this.id, this.name, this.url);

  factory LeagueInfo.fromJson(Map<String, dynamic> json) =>
      LeagueInfo(json['id'], json['name'], json['url']);

  factory LeagueInfo.allLeague() => LeagueInfo(-1, "All Leagues", "");

  @override
  String toString() => name;
}

class Events {
  final int id;
  final String name;
  final String url;
  final DateTimeRange date;
  final List<Discipline> disciplines;
  final List<Event> round;
  const Events(
      this.id, this.name, this.url, this.date, this.disciplines, this.round);

  factory Events.fromJson(Map<String, dynamic> json) {
    List<Event> localEvents = json['d_cats']
        .map((league) => Event.fromJson(league))
        .toList()
        .cast<Event>();
    List<Discipline> localDisciplines =
        localEvents.map((e) => e.discipline).toSet().toList();
    localDisciplines.sort((a, b) => a.index.compareTo(b.index));
    return Events(
      json['event_id'],
      json["event"].split(" - ").last,
      json["url"],
      DateTimeRange(
        start: DateTime.parse(json['starts_at'].replaceAll('UTC', 'Z')),
        end: DateTime.parse(json['ends_at'].replaceAll('UTC', 'Z')),
      ),
      localDisciplines,
      localEvents,
    );
  }

  factory Events.dummy() => Events(
        -1,
        "",
        "",
        DateTimeRange(
            start: DateTime.now().subtract(const Duration(days: 100)),
            end: DateTime.now()),
        [],
        [],
      );

  @override
  String toString() {
    return "$name: ${date.start.toLocal().toString()} - ${date.end.toLocal().toString()} (${date.toString()})";
  }

  String toLocalDateString() {
    final df = DateFormat('yyyy-MM-dd HH:mm');
    return "${df.format(date.start.toLocal())} - ${df.format(date.end.toLocal())}";
  }
}

class Event {
  final int id;
  final String name;
  final Discipline discipline;
  final bool isFemale;
  final IfscStatus status;
  final String resultUrl;
  final List<CatRound> cats;
  const Event(this.id, this.name, this.discipline, this.isFemale, this.status,
      this.resultUrl, this.cats);

  factory Event.fromJson(Map<String, dynamic> json) {
    final name = json['name'].split(' ');
    return Event(
      json['id'],
      json['name'],
      Discipline.values.byName(name[0].toLowerCase()),
      name[1] == 'Women',
      IfscStatus.values.byName(json['status']),
      json['result_url'],
      json['category_rounds']
          .map((cat) => CatRound.fromJson(cat))
          .toList()
          .cast<CatRound>(),
    );
  }

  // FIX: not sure about which status has result
  bool hasResult() =>
      (status == IfscStatus.active || status == IfscStatus.finished);
}

class CatRound {
  final String name;
  final int roundId;
  final IfscStatus status;
  final String resultUrl;
  const CatRound(this.name, this.roundId, this.status, this.resultUrl);

  factory CatRound.fromJson(Map<String, dynamic> json) => CatRound(
      (json['name'] == 'Final')
          ? 'final'
          : json['name'].substring(0, 4).toLowerCase(),
      json['category_round_id'],
      IfscStatus.values.byName(json['status']),
      json['result_url']);
}

enum IfscStatus {
  // ignore: constant_identifier_names
  registration_pending,
  // ignore: constant_identifier_names
  registration_active,
  pending,
  active,
  finished
}
