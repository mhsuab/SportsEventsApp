SeasonsInfo dummySeason = SeasonsInfo(-1, "", "", []);

class SeasonsInfo {
  final int id;
  final String url;
  final String name;
  final List<dynamic> leagues;
  SeasonsInfo(this.id, this.url, this.name, this.leagues);

  factory SeasonsInfo.fromJson(Map<String, dynamic> json) => SeasonsInfo(
      json['id'],
      json['url'],
      json['name'],
      json['leagues'].map((league) => LeagueInfo.fromJson(league)).toList());

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

  @override
  String toString() => name;
}
