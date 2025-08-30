class DebateModel {
  DebateModel({
    required this.success,
    required this.message,
    required this.data,
    required this.errors,
  });

  final bool success;
  final String message;
  final List<DebateData> data;
  final dynamic errors;

  DebateModel copyWith({
    bool? success,
    String? message,
    List<DebateData>? data,
    dynamic? errors,
  }) {
    return DebateModel(
      success: success ?? this.success,
      message: message ?? this.message,
      data: data ?? this.data,
      errors: errors ?? this.errors,
    );
  }

  factory DebateModel.fromJson(Map<String, dynamic> json) {
    return DebateModel(
      success: json["success"] ?? false,
      message: json["message"] ?? "",
      data:
          json["data"] == null
              ? []
              : List<DebateData>.from(
                json["data"]!.map((x) => DebateData.fromJson(x)),
              ),
      errors: json["errors"],
    );
  }
}

class DebateData {
  DebateData({
    required this.debateId,
    required this.startDate,
    required this.startTime,
    required this.type,
    required this.status,
    required this.filter,
    required this.motion,
    required this.chairJudge,
    required this.panelistJudges,
    required this.teams,
    required this.debaters,
    required this.applicantsCount,
    required this.debatersCount,
    required this.judgeCount,
    required this.isAbleToApply,
    this.isJoinedAsChairJudge = false,
    this.isJoinedAsPanelistJudge = false,
  });

  final int debateId;
  final DateTime? startDate;
  final String startTime;
  final String type;
  final String status;
  final dynamic filter;
  final Motion? motion;
  final ChairJudge? chairJudge;
  final List<PanelistJudge> panelistJudges;
  final List<Team> teams;
  final List<Debater> debaters;
  final num applicantsCount;
  final num debatersCount;
  final num judgeCount;
  final bool isAbleToApply;
  final bool isJoinedAsChairJudge;
  final bool isJoinedAsPanelistJudge;

  DebateData copyWith({
    int? debateId,
    DateTime? startDate,
    String? startTime,
    String? type,
    String? status,
    dynamic? filter,
    Motion? motion,
    ChairJudge? chairJudge,
    List<PanelistJudge>? panelistJudges,
    List<Team>? teams,
    List<Debater>? debaters,
    num? applicantsCount,
    num? debatersCount,
    num? judgeCount,
    bool? isAbleToApply,
    bool? isJoinedAsChairJudge,
    bool? isJoinedAsPanelistJudge,
  }) {
    return DebateData(
      debateId: debateId ?? this.debateId,
      startDate: startDate ?? this.startDate,
      startTime: startTime ?? this.startTime,
      type: type ?? this.type,
      status: status ?? this.status,
      filter: filter ?? this.filter,
      motion: motion ?? this.motion,
      chairJudge: chairJudge ?? this.chairJudge,
      panelistJudges: panelistJudges ?? this.panelistJudges,
      teams: teams ?? this.teams,
      debaters: debaters ?? this.debaters,
      applicantsCount: applicantsCount ?? this.applicantsCount,
      debatersCount: debatersCount ?? this.debatersCount,
      judgeCount: judgeCount ?? this.judgeCount,
      isAbleToApply: isAbleToApply ?? this.isAbleToApply,
      isJoinedAsChairJudge: isJoinedAsChairJudge ?? this.isJoinedAsChairJudge,
      isJoinedAsPanelistJudge:
          isJoinedAsPanelistJudge ?? this.isJoinedAsPanelistJudge,
    );
  }

  factory DebateData.fromJson(Map<String, dynamic> json) {
    return DebateData(
      debateId: json["debate_id"] ?? 0,
      startDate: DateTime.tryParse(json["start_date"] ?? ""),
      startTime: json["start_time"] ?? "",
      type: json["type"] ?? "",
      status: json["status"] ?? "",
      filter: json["filter"],
      motion: json["motion"] == null ? null : Motion.fromJson(json["motion"]),
      chairJudge:
          json["chair_judge"] == null
              ? null
              : ChairJudge.fromJson(json["chair_judge"]),
      panelistJudges:
          json["panelist_judges"] == null
              ? []
              : List<PanelistJudge>.from(
                json["panelist_judges"]!.map((x) => PanelistJudge.fromJson(x)),
              ),
      teams:
          json["teams"] == null
              ? []
              : List<Team>.from(json["teams"]!.map((x) => Team.fromJson(x))),
      debaters:
          json["debaters"] == null
              ? []
              : List<Debater>.from(
                json["debaters"]!.map((x) => Debater.fromJson(x)),
              ),
      applicantsCount: json["applicants_count"] ?? 0,
      debatersCount: json["debaters_count"] ?? 0,
      judgeCount: json["judge_count"] ?? 0,
      isAbleToApply: json["isAbleToApply"] ?? false,
    );
  }
}

class ChairJudge {
  ChairJudge({required this.chairJudgeId, required this.name});

  final int chairJudgeId;
  final String name;

  ChairJudge copyWith({int? chairJudgeId, String? name}) {
    return ChairJudge(
      chairJudgeId: chairJudgeId ?? this.chairJudgeId,
      name: name ?? this.name,
    );
  }

  factory ChairJudge.fromJson(Map<String, dynamic> json) {
    return ChairJudge(
      chairJudgeId: json["chair_judge_id"] ?? 0,
      name: json["name"] ?? "",
    );
  }
}

class Debater {
  Debater({
    required this.debaterId,
    required this.name,
    required this.speakerPosition,
    required this.teamRole,
    required this.rank,
    required this.teamNumber,
  });

  final int debaterId;
  final String name;
  final dynamic speakerPosition;
  final dynamic teamRole;
  final dynamic rank;
  final num teamNumber;

  Debater copyWith({
    int? debaterId,
    String? name,
    dynamic? speakerPosition,
    dynamic? teamRole,
    dynamic? rank,
    num? teamNumber,
  }) {
    return Debater(
      debaterId: debaterId ?? this.debaterId,
      name: name ?? this.name,
      speakerPosition: speakerPosition ?? this.speakerPosition,
      teamRole: teamRole ?? this.teamRole,
      rank: rank ?? this.rank,
      teamNumber: teamNumber ?? this.teamNumber,
    );
  }

  factory Debater.fromJson(Map<String, dynamic> json) {
    return Debater(
      debaterId: json["debater_id"] ?? 0,
      name: json["name"] ?? "",
      speakerPosition: json["speaker_position"],
      teamRole: json["team_role"],
      rank: json["rank"],
      teamNumber: json["team_number"] ?? 0,
    );
  }
}

class Motion {
  Motion({required this.motionId, required this.title, required this.type});

  final int motionId;
  final String title;
  final List<dynamic> type;

  Motion copyWith({int? motionId, String? title, List<dynamic>? type}) {
    return Motion(
      motionId: motionId ?? this.motionId,
      title: title ?? this.title,
      type: type ?? this.type,
    );
  }

  factory Motion.fromJson(Map<String, dynamic> json) {
    return Motion(
      motionId: json["motion_id"] ?? 0,
      title: json["title"] ?? "",
      type:
          json["type"] == null
              ? []
              : List<dynamic>.from(json["type"]!.map((x) => x)),
    );
  }
}

class PanelistJudge {
  PanelistJudge({required this.id, required this.name});

  final int id;
  final String name;

  PanelistJudge copyWith({int? id, String? name}) {
    return PanelistJudge(id: id ?? this.id, name: name ?? this.name);
  }

  factory PanelistJudge.fromJson(Map<String, dynamic> json) {
    return PanelistJudge(id: json["id"] ?? 0, name: json["name"] ?? "");
  }
}

class Team {
  Team({required this.teamNumber, required this.debaters});

  final num teamNumber;
  final List<Debater> debaters;

  Team copyWith({num? teamNumber, List<Debater>? debaters}) {
    return Team(
      teamNumber: teamNumber ?? this.teamNumber,
      debaters: debaters ?? this.debaters,
    );
  }

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      teamNumber: json["team_number"] ?? 0,
      debaters:
          json["debaters"] == null
              ? []
              : List<Debater>.from(
                json["debaters"]!.map((x) => Debater.fromJson(x)),
              ),
    );
  }
}
