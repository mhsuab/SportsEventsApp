import 'package:flutter/material.dart';

import 'package:sports/ifsc/network.dart';
import 'package:sports/ifsc/pages/pages.dart';
import 'package:sports/ifsc/data/athletes.dart';

import 'boulder.dart';

class DisciplineTypeNWidgets<S extends Athlete, T, U> {
  final Widget Function() skeletonListItem;
  final Widget Function(S?) listItemGeneral;
  final Widget Function(T?) listItem;
  final Function(Map<String, dynamic>) generator;
  final List<S> Function(List<S>, String) getRoundRanking;

  const DisciplineTypeNWidgets({
    required this.skeletonListItem,
    required this.listItemGeneral,
    required this.listItem,
    required this.generator,
    required this.getRoundRanking,
  });

  Type get baseAthletesType => S;
  Type get athleteGeneralType => T.runtimeType;
  Type get athleteType => U.runtimeType;
  Type getDataType(String cat) {
    if (cat == 'all') {
      return athleteGeneralType;
    } else {
      return athleteType;
    }
  }

  Future<List<S>> getGeneralRanking(String url) =>
      getIfscData(url, 'ranking', generator);
  Future<List<S>> getRanking(String url) =>
      getIfscData(url, 'ranking', generator);
  AthleteList<S> getAthleteList(List<S> athletes) =>
      AthleteList<S>(athletes, getRoundRanking);
}

Map<Discipline, DisciplineTypeNWidgets> resultMapping = {
  Discipline.combined: boulderWidget,
  Discipline.boulder: boulderWidget,
  Discipline.lead: boulderWidget,
  Discipline.speed: boulderWidget,
};
