import 'package:equatable/equatable.dart';

class DebatesModel extends Equatable {
    DebatesModel({
        required this.success,
        required this.message,
        required this.data,
        required this.errors,
    });

    final bool success;
    final String message;
    final List<Datum> data;
    final dynamic errors;

    DebatesModel copyWith({
        bool? success,
        String? message,
        List<Datum>? data,
        dynamic? errors,
    }) {
        return DebatesModel(
            success: success ?? this.success,
            message: message ?? this.message,
            data: data ?? this.data,
            errors: errors ?? this.errors,
        );
    }

    factory DebatesModel.fromJson(Map<String, dynamic> json){ 
        return DebatesModel(
            success: json["success"] ?? false,
            message: json["message"] ?? "",
            data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
            errors: json["errors"],
        );
    }

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data.map((x) => x?.toJson()).toList(),
        "errors": errors,
    };

    @override
    List<Object?> get props => [
    success, message, data, errors, ];
}

class Datum extends Equatable {
    Datum({
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
    final List<dynamic> panelistJudges;
    final List<Team> teams;
    final List<Debater> debaters;
    final int applicantsCount;
    final int debatersCount;
    final int judgeCount;
    final bool isAbleToApply;

    Datum copyWith({
        int? debateId,
        DateTime? startDate,
        String? startTime,
        String? type,
        String? status,
        dynamic? filter,
        Motion? motion,
        ChairJudge? chairJudge,
        List<dynamic>? panelistJudges,
        List<Team>? teams,
        List<Debater>? debaters,
        int? applicantsCount,
        int? debatersCount,
        int? judgeCount,
        bool? isAbleToApply,
    }) {
        return Datum(
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

    factory Datum.fromJson(Map<String, dynamic> json){ 
        return Datum(
            debateId: json["debate_id"] ?? 0,
            startDate: DateTime.tryParse(json["start_date"] ?? ""),
            startTime: json["start_time"] ?? "",
            type: json["type"] ?? "",
            status: json["status"] ?? "",
            filter: json["filter"],
            motion: json["motion"] == null ? null : Motion.fromJson(json["motion"]),
            chairJudge: json["chair_judge"] == null ? null : ChairJudge.fromJson(json["chair_judge"]),
            panelistJudges: json["panelist_judges"] == null ? [] : List<dynamic>.from(json["panelist_judges"]!.map((x) => x)),
            teams: json["teams"] == null ? [] : List<Team>.from(json["teams"]!.map((x) => Team.fromJson(x))),
            debaters: json["debaters"] == null ? [] : List<Debater>.from(json["debaters"]!.map((x) => Debater.fromJson(x))),
            applicantsCount: json["applicants_count"] ?? 0,
            debatersCount: json["debaters_count"] ?? 0,
            judgeCount: json["judge_count"] ?? 0,
            isAbleToApply: json["isAbleToApply"] ?? false,
        );
    }

    Map<String, dynamic> toJson() => {
        "debate_id": debateId,
        "start_date": "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
        "start_time": startTime,
        "type": type,
        "status": status,
        "filter": filter,
        "motion": motion?.toJson(),
        "chair_judge": chairJudge?.toJson(),
        "panelist_judges": panelistJudges.map((x) => x).toList(),
        "teams": teams.map((x) => x?.toJson()).toList(),
        "debaters": debaters.map((x) => x?.toJson()).toList(),
        "applicants_count": applicantsCount,
        "debaters_count": debatersCount,
        "judge_count": judgeCount,
        "isAbleToApply": isAbleToApply,
    };

    @override
    List<Object?> get props => [
    debateId, startDate, startTime, type, status, filter, motion, chairJudge, panelistJudges, teams, debaters, applicantsCount, debatersCount, judgeCount, isAbleToApply, ];
}

class ChairJudge extends Equatable {
    ChairJudge({
        required this.chairJudgeId,
        required this.name,
    });

    final int chairJudgeId;
    final String name;

    ChairJudge copyWith({
        int? chairJudgeId,
        String? name,
    }) {
        return ChairJudge(
            chairJudgeId: chairJudgeId ?? this.chairJudgeId,
            name: name ?? this.name,
        );
    }

    factory ChairJudge.fromJson(Map<String, dynamic> json){ 
        return ChairJudge(
            chairJudgeId: json["chair_judge_id"] ?? 0,
            name: json["name"] ?? "",
        );
    }

    Map<String, dynamic> toJson() => {
        "chair_judge_id": chairJudgeId,
        "name": name,
    };

    @override
    List<Object?> get props => [
    chairJudgeId, name, ];
}

class Debater extends Equatable {
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
    final int teamNumber;

    Debater copyWith({
        int? debaterId,
        String? name,
        dynamic? speakerPosition,
        dynamic? teamRole,
        dynamic? rank,
        int? teamNumber,
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

    factory Debater.fromJson(Map<String, dynamic> json){ 
        return Debater(
            debaterId: json["debater_id"] ?? 0,
            name: json["name"] ?? "",
            speakerPosition: json["speaker_position"],
            teamRole: json["team_role"],
            rank: json["rank"],
            teamNumber: json["team_number"] ?? 0,
        );
    }

    Map<String, dynamic> toJson() => {
        "debater_id": debaterId,
        "name": name,
        "speaker_position": speakerPosition,
        "team_role": teamRole,
        "rank": rank,
        "team_number": teamNumber,
    };

    @override
    List<Object?> get props => [
    debaterId, name, speakerPosition, teamRole, rank, teamNumber, ];
}

class Motion extends Equatable {
    Motion({
        required this.motionId,
        required this.title,
        required this.type,
    });

    final int motionId;
    final String title;
    final List<dynamic> type;

    Motion copyWith({
        int? motionId,
        String? title,
        List<dynamic>? type,
    }) {
        return Motion(
            motionId: motionId ?? this.motionId,
            title: title ?? this.title,
            type: type ?? this.type,
        );
    }

    factory Motion.fromJson(Map<String, dynamic> json){ 
        return Motion(
            motionId: json["motion_id"] ?? 0,
            title: json["title"] ?? "",
            type: json["type"] == null ? [] : List<dynamic>.from(json["type"]!.map((x) => x)),
        );
    }

    Map<String, dynamic> toJson() => {
        "motion_id": motionId,
        "title": title,
        "type": type.map((x) => x).toList(),
    };

    @override
    List<Object?> get props => [
    motionId, title, type, ];
}

class Team extends Equatable {
    Team({
        required this.teamNumber,
        required this.debaters,
    });

    final int teamNumber;
    final List<Debater> debaters;

    Team copyWith({
        int? teamNumber,
        List<Debater>? debaters,
    }) {
        return Team(
            teamNumber: teamNumber ?? this.teamNumber,
            debaters: debaters ?? this.debaters,
        );
    }

    factory Team.fromJson(Map<String, dynamic> json){ 
        return Team(
            teamNumber: json["team_number"] ?? 0,
            debaters: json["debaters"] == null ? [] : List<Debater>.from(json["debaters"]!.map((x) => Debater.fromJson(x))),
        );
    }

    Map<String, dynamic> toJson() => {
        "team_number": teamNumber,
        "debaters": debaters.map((x) => x?.toJson()).toList(),
    };

    @override
    List<Object?> get props => [
    teamNumber, debaters, ];
}

// import 'package:equatable/equatable.dart';

// class DebatesModel extends Equatable {
//     DebatesModel({
//         required this.success,
//         required this.message,
//         required this.data,
//         required this.errors,
//     });

//     final bool success;
//     final String message;
//     final List<Datum> data;
//     final dynamic errors;

//     DebatesModel copyWith({
//         bool? success,
//         String? message,
//         List<Datum>? data,
//         dynamic? errors,
//     }) {
//         return DebatesModel(
//             success: success ?? this.success,
//             message: message ?? this.message,
//             data: data ?? this.data,
//             errors: errors ?? this.errors,
//         );
//     }

//     factory DebatesModel.fromJson(Map<String, dynamic> json){ 
//         return DebatesModel(
//             success: json["success"] ?? false,
//             message: json["message"] ?? "",
//             data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
//             errors: json["errors"],
//         );
//     }

//     Map<String, dynamic> toJson() => {
//         "success": success,
//         "message": message,
//         "data": data.map((x) => x?.toJson()).toList(),
//         "errors": errors,
//     };

//     @override
//     List<Object?> get props => [
//     success, message, data, errors, ];
// }

// class Datum extends Equatable {
//     Datum({
//         required this.debateId,
//         required this.startDate,
//         required this.startTime,
//         required this.type,
//         required this.status,
//         required this.filter,
//         required this.motion,
//         required this.chairJudge,
//         required this.applicantsCount,
//         required this.isAbleToApply,
//     });

//     final int debateId;
//     final DateTime? startDate;
//     final String startTime;
//     final String type;
//     final String status;
//     final dynamic filter;
//     final dynamic motion;
//     final dynamic chairJudge;
//     final int applicantsCount;
//     final bool isAbleToApply;

//     Datum copyWith({
//         int? debateId,
//         DateTime? startDate,
//         String? startTime,
//         String? type,
//         String? status,
//         dynamic? filter,
//         dynamic? motion,
//         dynamic? chairJudge,
//         int? applicantsCount,
//         bool? isAbleToApply,
//     }) {
//         return Datum(
//             debateId: debateId ?? this.debateId,
//             startDate: startDate ?? this.startDate,
//             startTime: startTime ?? this.startTime,
//             type: type ?? this.type,
//             status: status ?? this.status,
//             filter: filter ?? this.filter,
//             motion: motion ?? this.motion,
//             chairJudge: chairJudge ?? this.chairJudge,
//             applicantsCount: applicantsCount ?? this.applicantsCount,
//             isAbleToApply: isAbleToApply ?? this.isAbleToApply,
//         );
//     }

//     factory Datum.fromJson(Map<String, dynamic> json){ 
//         return Datum(
//             debateId: json["debate_id"] ?? 0,
//             startDate: DateTime.tryParse(json["start_date"] ?? ""),
//             startTime: json["start_time"] ?? "",
//             type: json["type"] ?? "",
//             status: json["status"] ?? "",
//             filter: json["filter"],
//             motion: json["motion"],
//             chairJudge: json["chair_judge"],
//             applicantsCount: json["applicants_count"] ?? 0,
//             isAbleToApply: json["is_able_to_apply"] ?? false,
//         );
//     }

//     Map<String, dynamic> toJson() => {
//         "debate_id": debateId,
//         "start_date": startDate?.toIso8601String(),
//         "start_time": startTime,
//         "type": type,
//         "status": status,
//         "filter": filter,
//         "motion": motion,
//         "chair_judge": chairJudge,
//         "applicants_count": applicantsCount,
//         "is_able_to_apply": isAbleToApply,
//     };

//     @override
//     List<Object?> get props => [
//     debateId, startDate, startTime, type, status, filter, motion, chairJudge, applicantsCount, isAbleToApply, ];
// }
