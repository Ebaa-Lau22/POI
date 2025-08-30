import 'package:poi/features/Debates/data/enums/judge_type.dart';

class SendRequestFromJudgeDto {
  final int debateid;
  final JudgeType judgeType;

  SendRequestFromJudgeDto({required this.judgeType, required this.debateid});
  Map<String, dynamic> toJson() => {'judge_type': judgeType.name};
}
