class AddFeedbackResponseModel {
  AddFeedbackResponseModel({required this.message, required this.feedback});

  final String message;
  final AddFeedBack? feedback;

  factory AddFeedbackResponseModel.fromJson(Map<String, dynamic> json) {
    return AddFeedbackResponseModel(
      message: json["message"] ?? "",
      feedback:
          json["feedback"] == null
              ? null
              : AddFeedBack.fromJson(json["feedback"]),
    );
  }
}

class AddFeedBack {
  AddFeedBack({
    required this.participantDebaterId,
    required this.note,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  final int participantDebaterId;
  final String note;
  final DateTime? updatedAt;
  final DateTime? createdAt;
  final int id;

  factory AddFeedBack.fromJson(Map<String, dynamic> json) {
    return AddFeedBack(
      participantDebaterId: json["participant_debater_id"] ?? 0,
      note: json["note"] ?? "",
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      id: json["id"] ?? 0,
    );
  }
}
