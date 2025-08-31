class FinishDebateResponseModel {
  FinishDebateResponseModel({
    required this.success,
    required this.message,
    required this.data,
    required this.errors,
  });

  final bool success;
  final String message;
  final List<FinishDebateData> data;
  final dynamic errors;

  FinishDebateResponseModel copyWith({
    bool? success,
    String? message,
    List<FinishDebateData>? data,
    dynamic? errors,
  }) {
    return FinishDebateResponseModel(
      success: success ?? this.success,
      message: message ?? this.message,
      data: data ?? this.data,
      errors: errors ?? this.errors,
    );
  }

  factory FinishDebateResponseModel.fromJson(Map<String, dynamic> json) {
    return FinishDebateResponseModel(
      success: json["success"] ?? false,
      message: json["message"] ?? "",
      data: json["data"] == null
          ? []
          : List<FinishDebateData>.from(
              json["data"]!.map((x) => FinishDebateData.fromJson(x)),
            ),
      errors: json["errors"],
    );
  }
}

class FinishDebateData {
  FinishDebateData({
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

  FinishDebateData copyWith({
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
  }) {
    return FinishDebateData(
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
    );
  }

  factory FinishDebateData.fromJson(Map<String, dynamic> json) {
    return FinishDebateData(
      debateId: json["debate_id"] ?? 0,
      startDate: DateTime.tryParse(json["start_date"] ?? ""),
      startTime: json["start_time"] ?? "",
      type: json["type"] ?? "",
      status: json["status"] ?? "",
      filter: json["filter"],
      motion: json["motion"] == null ? null : Motion.fromJson(json["motion"]),
      chairJudge: json["chair_judge"] == null
          ? null
          : ChairJudge.fromJson(json["chair_judge"]),
      panelistJudges: json["panelist_judges"] == null
          ? []
          : List<PanelistJudge>.from(
              json["panelist_judges"]!.map((x) => PanelistJudge.fromJson(x))),
      teams: json["teams"] == null
          ? []
          : List<Team>.from(json["teams"]!.map((x) => Team.fromJson(x))),
      debaters: json["debaters"] == null
          ? []
          : List<Debater>.from(
              json["debaters"]!.map((x) => Debater.fromJson(x))),
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

  factory Motion.fromJson(Map<String, dynamic> json) {
    return Motion(
      motionId: json["motion_id"] ?? 0,
      title: json["title"] ?? "",
      type: json["type"] == null
          ? []
          : List<dynamic>.from(json["type"]!.map((x) => x)),
    );
  }
}

class PanelistJudge {
  PanelistJudge({required this.id, required this.name});

  final int id;
  final String name;

  factory PanelistJudge.fromJson(Map<String, dynamic> json) {
    return PanelistJudge(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
    );
  }
}

class Team {
  Team({required this.teamNumber, required this.debaters});

  final num teamNumber;
  final List<Debater> debaters;

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      teamNumber: json["team_number"] ?? 0,
      debaters: json["debaters"] == null
          ? []
          : List<Debater>.from(
              json["debaters"]!.map((x) => Debater.fromJson(x))),
    );
  }
}
