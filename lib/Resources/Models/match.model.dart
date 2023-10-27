class MatchModel {
  String? id;
  String? firstTeam;
  String? firstTeamScore;
  String? secondTeam;
  String? secondTeamScore;
  String? matchDate;
  String? matchTime, comment;
  String? createdAt;
  String? isPassed;

  MatchModel(
      {this.id,
      this.firstTeam,
      this.firstTeamScore,
      this.secondTeam,
      this.secondTeamScore,
      this.matchDate,
      this.matchTime,
      this.createdAt,
      this.comment,
      this.isPassed});

  static fromJSON(json) {
    MatchModel data = MatchModel()
      ..id = json['id']?.toString()
      ..firstTeam = json['first_team']
      ..firstTeamScore = json['first_team_score']?.toString()
      ..secondTeam = json['second_team']
      ..secondTeamScore = json['second_team_score']?.toString()
      ..matchDate = json['match_date']
      ..matchTime = json['match_time']
      ..createdAt = json['created_at']
      ..comment = json['comment']
      ..isPassed = json['isPassed']?.toString();
    return data;
  }

  Map<String, dynamic> toJSON() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (data['id'] != null) data['id'] = id;
    data['first_team'] = firstTeam;
    data['first_team_score'] = firstTeamScore;
    data['second_team'] = secondTeam;
    data['second_team_score'] = secondTeamScore;
    data['match_date'] = matchDate;
    data['match_time'] = matchTime;
    if (data['created_at'] != null) data['created_at'] = createdAt;
    data['comment'] = comment ?? '';
    return data;
  }
}
