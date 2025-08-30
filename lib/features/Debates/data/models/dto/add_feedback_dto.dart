class AddFeedbackDto {
  final int participantDebaterId;
  final String note;

  AddFeedbackDto({required this.participantDebaterId, required this.note});
  Map<String, dynamic> toJson() => {
    'participant_debater_id': participantDebaterId,
    'note': note,
  };
}
