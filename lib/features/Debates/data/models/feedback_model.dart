class FeedbackModel {
  FeedbackModel({required this.debateId, required this.feedbacks});

  final String debateId;
  final List<Feedback> feedbacks;

  factory FeedbackModel.fromJson(Map<String, dynamic> json) {
    return FeedbackModel(
      debateId: json["debate_id"] ?? "",
      feedbacks:
          json["feedbacks"] == null
              ? []
              : List<Feedback>.from(
                json["feedbacks"]!.map((x) => Feedback.fromJson(x)),
              ),
    );
  }
}

class Feedback {
  Feedback({
    required this.id,
    required this.participantDebaterId,
    required this.note,
    required this.createdAt,
    required this.updatedAt,
    required this.participant,
  });

  final int id;
  final int participantDebaterId;
  final String note;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Participant? participant;

  factory Feedback.fromJson(Map<String, dynamic> json) {
    return Feedback(
      id: json["id"] ?? 0,
      participantDebaterId: json["participant_debater_id"] ?? 0,
      note: json["note"] ?? "",
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      participant:
          json["participant"] == null
              ? null
              : Participant.fromJson(json["participant"]),
    );
  }
}

class Participant {
  Participant({
    required this.id,
    required this.debateId,
    required this.debaterId,
    required this.teamNumber,
    required this.speakerId,
    required this.rank,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final int debateId;
  final int debaterId;
  final int teamNumber;
  final dynamic speakerId;
  final dynamic rank;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Participant.fromJson(Map<String, dynamic> json) {
    return Participant(
      id: json["id"] ?? 0,
      debateId: json["debate_id"] ?? 0,
      debaterId: json["debater_id"] ?? 0,
      teamNumber: json["team_number"] ?? 0,
      speakerId: json["speaker_id"],
      rank: json["rank"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }
}
