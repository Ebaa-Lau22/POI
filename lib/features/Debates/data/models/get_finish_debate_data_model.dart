import 'package:equatable/equatable.dart';

class GetFinishDebateDataModel extends Equatable {
    GetFinishDebateDataModel({
        required this.success,
        required this.message,
        required this.data,
        required this.errors,
    });

    final bool success;
    final String message;
    final List<Datum> data;
    final dynamic errors;

    GetFinishDebateDataModel copyWith({
        bool? success,
        String? message,
        List<Datum>? data,
        dynamic? errors,
    }) {
        return GetFinishDebateDataModel(
            success: success ?? this.success,
            message: message ?? this.message,
            data: data ?? this.data,
            errors: errors ?? this.errors,
        );
    }

    factory GetFinishDebateDataModel.fromJson(Map<String, dynamic> json){ 
        return GetFinishDebateDataModel(
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
        required this.teamNumber,
        required this.teamRole,
        required this.debaters,
    });

    final int teamNumber;
    final String teamRole;
    final List<Debater> debaters;

    Datum copyWith({
        int? teamNumber,
        String? teamRole,
        List<Debater>? debaters,
    }) {
        return Datum(
            teamNumber: teamNumber ?? this.teamNumber,
            teamRole: teamRole ?? this.teamRole,
            debaters: debaters ?? this.debaters,
        );
    }

    factory Datum.fromJson(Map<String, dynamic> json){ 
        return Datum(
            teamNumber: json["team_number"] ?? 0,
            teamRole: json["team_role"] ?? "",
            debaters: json["debaters"] == null ? [] : List<Debater>.from(json["debaters"]!.map((x) => Debater.fromJson(x))),
        );
    }

    Map<String, dynamic> toJson() => {
        "team_number": teamNumber,
        "team_role": teamRole,
        "debaters": debaters.map((x) => x?.toJson()).toList(),
    };

    @override
    List<Object?> get props => [
    teamNumber, teamRole, debaters, ];
}

class Debater extends Equatable {
    Debater({
        required this.debaterId,
        required this.name,
        required this.speakerPosition,
    });

    final int debaterId;
    final String name;
    final String speakerPosition;

    Debater copyWith({
        int? debaterId,
        String? name,
        String? speakerPosition,
    }) {
        return Debater(
            debaterId: debaterId ?? this.debaterId,
            name: name ?? this.name,
            speakerPosition: speakerPosition ?? this.speakerPosition,
        );
    }

    factory Debater.fromJson(Map<String, dynamic> json){ 
        return Debater(
            debaterId: json["debater_id"] ?? 0,
            name: json["name"] ?? "",
            speakerPosition: json["speaker_position"] ?? "",
        );
    }

    Map<String, dynamic> toJson() => {
        "debater_id": debaterId,
        "name": name,
        "speaker_position": speakerPosition,
    };

    @override
    List<Object?> get props => [
    debaterId, name, speakerPosition, ];
}
