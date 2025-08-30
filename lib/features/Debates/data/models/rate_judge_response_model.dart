class RateJudgeResponseModel {
    RateJudgeResponseModel({
        required this.success,
        required this.data,
        required this.message,
    });

    final bool success;
    final Data? data;
    final String message;

    factory RateJudgeResponseModel.fromJson(Map<String, dynamic> json){ 
        return RateJudgeResponseModel(
            success: json["success"] ?? false,
            data: json["data"] == null ? null : Data.fromJson(json["data"]),
            message: json["message"] ?? "",
        );
    }

}

class Data {
    Data({
        required this.participantDebaterId,
        required this.judgeId,
        required this.rate,
        required this.opinion,
        required this.updatedAt,
        required this.createdAt,
        required this.id,
    });

    final int participantDebaterId;
    final int judgeId;
    final int rate;
    final String opinion;
    final DateTime? updatedAt;
    final DateTime? createdAt;
    final int id;

    factory Data.fromJson(Map<String, dynamic> json){ 
        return Data(
            participantDebaterId: json["participant_debater_id"] ?? 0,
            judgeId: json["judge_id"] ?? 0,
            rate: json["rate"] ?? 0,
            opinion: json["opinion"] ?? "",
            updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
            createdAt: DateTime.tryParse(json["created_at"] ?? ""),
            id: json["id"] ?? 0,
        );
    }

}