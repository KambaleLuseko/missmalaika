import 'partner.model.dart';

class DashboardModel {
  Dashboard? dashboard;
  List<CandidateModel>? candidatesStats;

  DashboardModel({this.dashboard, this.candidatesStats});

  static fromJson(json) {
    DashboardModel data = DashboardModel()
      ..dashboard = json['dashboard'] != null
          ? Dashboard.fromJson(json['dashboard'])
          : null
      ..candidatesStats = <CandidateModel>[];
    if (json['candidatesStats'] != null) {
      json['candidatesStats'].forEach((v) {
        data.candidatesStats!.add(CandidateModel.fromJson(v));
      });
    }
    return data;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (dashboard != null) {
      data['dashboard'] = dashboard!.toJson();
    }
    if (candidatesStats != null) {
      data['candidatesStats'] =
          candidatesStats!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Dashboard {
  String? totalCandidates;
  String? confirmedInscriptions;
  String? userConfirmedVotes;
  String? userPendingVotes;
  String? totalUserConfirmedPoints;
  String? totalUserPendingPoints;

  Dashboard(
      {this.totalCandidates,
      this.confirmedInscriptions,
      this.userConfirmedVotes,
      this.userPendingVotes,
      this.totalUserConfirmedPoints,
      this.totalUserPendingPoints});

  Dashboard.fromJson(Map<String, dynamic> json) {
    totalCandidates = json['totalCandidates'];
    confirmedInscriptions = json['confirmedInscriptions'];
    userConfirmedVotes = json['userConfirmedVotes'];
    userPendingVotes = json['userPendingVotes'];
    totalUserConfirmedPoints = json['totalUserConfirmedPoints'];
    totalUserPendingPoints = json['totalUserPendingPoints'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalCandidates'] = totalCandidates;
    data['confirmedInscriptions'] = confirmedInscriptions;
    data['userConfirmedVotes'] = userConfirmedVotes;
    data['userPendingVotes'] = userPendingVotes;
    data['totalUserConfirmedPoints'] = totalUserConfirmedPoints;
    data['totalUserPendingPoints'] = totalUserPendingPoints;
    return data;
  }
}

class Votes {
  String? countConfirmed;
  String? totalConfirmedPoints;
  String? userConfirmedVotes;
  String? userPendingVotes;
  String? totalUserConfirmedPoints;
  String? totalUserPendingPoints;

  Votes(
      {this.countConfirmed,
      this.totalConfirmedPoints,
      this.userConfirmedVotes,
      this.userPendingVotes,
      this.totalUserConfirmedPoints,
      this.totalUserPendingPoints});

  Votes.fromJson(Map<String, dynamic> json) {
    countConfirmed = json['countConfirmed'];
    totalConfirmedPoints = json['totalConfirmedPoints'];
    userConfirmedVotes = json['userConfirmedVotes'];
    userPendingVotes = json['userPendingVotes'];
    totalUserConfirmedPoints = json['totalUserConfirmedPoints'];
    totalUserPendingPoints = json['totalUserPendingPoints'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['countConfirmed'] = countConfirmed;
    data['totalConfirmedPoints'] = totalConfirmedPoints;
    data['userConfirmedVotes'] = userConfirmedVotes;
    data['userPendingVotes'] = userPendingVotes;
    data['totalUserConfirmedPoints'] = totalUserConfirmedPoints;
    data['totalUserPendingPoints'] = totalUserPendingPoints;
    return data;
  }
}
