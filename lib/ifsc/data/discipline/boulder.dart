import 'package:flutter/material.dart';
import 'package:sports/ifsc/data/data.dart';

DisciplineTypeNWidgets boulderWidget =
    DisciplineTypeNWidgets<BoulderAthlete, BoulderRound, BoulderRoute>(
        skeletonListItem: (() => Container()),
        listItemGeneral: ((p0) => Container()),
        listItem: ((p0) => Container()),
        generator: BoulderAthlete.fromJson,
        getRoundRanking: ((List<BoulderAthlete> athletes, String cat) {
          final round = athletes
              .where((element) => element.rounds.containsKey(cat))
              .toList();
          round.sort((a, b) {
            if (a.rounds[cat]!.rank == null) return 1;
            if (b.rounds[cat]!.rank == null) return -1;
            return a.rounds[cat]!.rank!.compareTo(b.rounds[cat]!.rank!);
          });
          return round;
        }));

class BoulderAthlete extends Athlete {
  final int? rank;
  final Map<String, BoulderRound> rounds;
  final bool isGeneral;

  const BoulderAthlete(
      int id,
      String firstname,
      String lastname,
      DateTime? birthday,
      String? gender,
      String country,
      this.rank,
      this.rounds,
      this.isGeneral)
      : super(id, firstname, lastname, birthday, gender, country);

  factory BoulderAthlete.fromJson(Map<String, dynamic> json) => BoulderAthlete(
      json['athlete_id'],
      json['firstname'],
      json['lastname'],
      null,
      null,
      json['country'],
      json['rank'],
      {
        for (BoulderRound round in json['rounds']
            .map((round) => BoulderRound.fromJson(round))
            .toList()
            .cast<BoulderRound>())
          round.name: round
      }.cast<String, BoulderRound>(),
      true);

  @override
  String toString() => name;
}

class BoulderRound {
  final int id;
  final String name;
  final int? rank;
  final String score;
  final List<BoulderRoute> routes;

  const BoulderRound(this.id, this.name, this.rank, this.score, this.routes);

  factory BoulderRound.fromJson(Map<String, dynamic> json) {
    final routes =
        json['ascents'] ?? json['speed_elimination_stages']['ascents'];
    return BoulderRound(
      json['category_round_id'],
      (json['round_name'].toLowerCase() == 'final')
          ? 'final'
          : json['round_name'].substring(0, 4).toLowerCase(),
      json['rank'],
      json['score'],
      routes
          .map((route) => BoulderRoute.fromJson(route))
          .toList()
          .cast<BoulderRoute>(),
    );
  }
}

class BoulderRoute {
  final int id;
  final String? name;
  final bool? top;
  // ignore: non_constant_identifier_names
  final int? top_tries;
  final bool? zone;
  // ignore: non_constant_identifier_names
  final int? zone_tries;
  // ignore: non_constant_identifier_names
  final bool? low_zone;
  // ignore: non_constant_identifier_names
  final int? low_zone_tries;

  const BoulderRoute(this.id, this.name, this.top, this.top_tries, this.zone,
      this.zone_tries, this.low_zone, this.low_zone_tries);

  factory BoulderRoute.fromJson(Map<String, dynamic> json) => BoulderRoute(
        json["route_id"],
        json["route_name"],
        json["top"],
        json["top_tries"],
        json["zone"],
        json["zone_tries"],
        json["low_zone"],
        json["low_zone_tries"],
      );
}
