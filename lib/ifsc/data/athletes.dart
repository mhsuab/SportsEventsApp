class Athlete {
  final int id;
  final String firstname;
  final String lastname;
  final DateTime? birthday;
  final String? gender;
  final String country;
  const Athlete(this.id, this.firstname, this.lastname, this.birthday,
      this.gender, this.country);

  String get name => "$firstname $lastname";

  factory Athlete.fromJson(Map<String, dynamic> json) => Athlete(
        json['id'],
        json['firstname'],
        json['lastname'],
        json['birthday'],
        json['gender'],
        json['ioc_code'],
      );
}

class AthleteList<T extends Athlete> {
  final List<T> _athletes;
  List<T> get athletes => List.unmodifiable(_athletes);

  final List<T> Function(List<T>, String) _getRoundRanking;

  const AthleteList(this._athletes, this._getRoundRanking);

  List<T> ranking(String cat) {
    if (cat == 'all') return athletes;
    return _ranking(cat);
  }

  List<T> _ranking(String cat) => _getRoundRanking(athletes, cat);
}
