class GetFeedbackByDebaterResponseModel {
  GetFeedbackByDebaterResponseModel({
    required this.success,
    required this.message,
    required this.data,
    required this.errors,
  });

  final bool success;
  final String message;
  final List<GetFeedbackByDebaterResponseData> data;
  final dynamic errors;

  factory GetFeedbackByDebaterResponseModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return GetFeedbackByDebaterResponseModel(
      success: json["success"] ?? false,
      message: json["message"] ?? "",
      data:
          json["data"] == null
              ? []
              : List<GetFeedbackByDebaterResponseData>.from(
                json["data"]!.map(
                  (x) => GetFeedbackByDebaterResponseData.fromJson(x),
                ),
              ),
      errors: json["errors"],
    );
  }
}

class GetFeedbackByDebaterResponseData {
  GetFeedbackByDebaterResponseData({
    required this.judgeName,
    required this.feedback,
    required this.debateId,
    required this.debateDate,
    required this.motionSentence,
    required this.teamRole,
    required this.speakerPosition,
  });

  final String judgeName;
  final String feedback;
  final int debateId;
  final DateTime? debateDate;
  final String motionSentence;
  final String teamRole;
  final String speakerPosition;

  factory GetFeedbackByDebaterResponseData.fromJson(Map<String, dynamic> json) {
    return GetFeedbackByDebaterResponseData(
      judgeName: json["judge_name"] ?? "",
      feedback: json["feedback"] ?? "",
      debateId: json["debate_id"] ?? 0,
      debateDate: DateTime.tryParse(json["debate_date"] ?? ""),
      motionSentence: json["motion_sentence"] ?? "",
      teamRole: json["team_role"] ?? "",
      speakerPosition: json["speaker_position"] ?? "",
    );
  }
}
