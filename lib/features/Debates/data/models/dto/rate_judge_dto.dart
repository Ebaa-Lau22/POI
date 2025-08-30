class RateJudgeDto {
  RateJudgeDto({
    required this.judgeId,
    required this.debateId,
    required this.rate,
    required this.opinion,
  });

  final int judgeId;
  final int debateId;
  final num rate;
  final String opinion;

  Map<String, dynamic> toJson() => {
    'judge_id': judgeId,
    'debate_id': debateId,
    'rate': rate,
    'opinion': opinion,
  };
}
