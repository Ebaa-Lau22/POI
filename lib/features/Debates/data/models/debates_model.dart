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
        required this.applicantsCount,
        required this.isAbleToApply,
    });

    final int debateId;
    final DateTime? startDate;
    final String startTime;
    final String type;
    final String status;
    final dynamic filter;
    final dynamic motion;
    final dynamic chairJudge;
    final int applicantsCount;
    final bool isAbleToApply;

    Datum copyWith({
        int? debateId,
        DateTime? startDate,
        String? startTime,
        String? type,
        String? status,
        dynamic? filter,
        dynamic? motion,
        dynamic? chairJudge,
        int? applicantsCount,
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
            applicantsCount: applicantsCount ?? this.applicantsCount,
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
            motion: json["motion"],
            chairJudge: json["chair_judge"],
            applicantsCount: json["applicants_count"] ?? 0,
            isAbleToApply: json["is_able_to_apply"] ?? false,
        );
    }

    Map<String, dynamic> toJson() => {
        "debate_id": debateId,
        "start_date": startDate?.toIso8601String(),
        "start_time": startTime,
        "type": type,
        "status": status,
        "filter": filter,
        "motion": motion,
        "chair_judge": chairJudge,
        "applicants_count": applicantsCount,
        "is_able_to_apply": isAbleToApply,
    };

    @override
    List<Object?> get props => [
    debateId, startDate, startTime, type, status, filter, motion, chairJudge, applicantsCount, isAbleToApply, ];
}
